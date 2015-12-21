require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  let(:current_user) { FactoryGirl.create :user }
  before { api_authorization_header current_user.auth_token }
  describe "GET #index" do
    before do
      4.times { FactoryGirl.create :order, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 orders from the user" do
      expect(json_response[:orders].size).to eql 4
    end

    it { is_expected.to respond_with 200 }
  end

  describe "GET #show" do
    let(:product) { FactoryGirl.create :product } 
    let(:order) { FactoryGirl.create :order, user: current_user, product_ids: [product.id] } 
    before do
      get :show, user_id: current_user.id, id: order.id
    end

    it "returns the order record" do
      expect(json_response[:order][:id]).to eql order.id  
    end

    it { is_expected.to respond_with 200 }

    it { expect(json_response[:order][:total]).to eql order.total.to_s }
    it { expect(json_response[:order][:products].count).to eql 1}
  end

  describe "POST #create" do
    let(:product1) { FactoryGirl.create :product } 
    let(:product2) { FactoryGirl.create :product } 
    before do
      order_params =  { product_ids_and_quantities: [[product1.id, 2], [product2.id, 3]]}
      post :create, user_id: current_user.id, order: order_params
    end

    it "returns the order record" do
      expect(json_response[:order][:id]).to be_present
    end

    it "embeds the two product objects related to the order" do
      expect(json_response[:order][:products].size).to eql 2
    end

    it { should respond_with 201 }
  end
end
