require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #show" do
    let(:product) { FactoryGirl.create :product }
    before { get :show, id: product.id }

    it "returns the information about a reporter on a hash" do
      expect(json_response[:title]).to eql product.title
    end

    it { is_expected.to respond_with 200 }
  end

  describe "GET #index" do
    before do
      4.times { FactoryGirl.create :product }
      get :index
    end

    it "returns 4 records" do
      expect(json_response[:products].count).to be 4
    end

    it { is_expected.to respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      let(:user) { FactoryGirl.create :user }
      let(:product_attributes) { FactoryGirl.attributes_for :product } 
      before do
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, product: product_attributes }
      end

      it "renders the json reprentation for the product record just created" do
        expect(json_response[:title]).to eql product_attributes[:title]
      end

      it { is_expected.to respond_with 201 }
    end

    context "when not created" do
      let(:user) { FactoryGirl.create :user }
      let(:product_attributes) { { title: "Pen", price: "Twelve" } } 
      before do
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, product: product_attributes }
      end

      it "renders errors" do
        expect(json_response).to have_key(:errors)
      end

      it { expect(json_response[:errors][:price]).to include "is not a number" }
      it { is_expected.to respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    let(:user) { FactoryGirl.create :user }
    let(:product) { FactoryGirl.create :product, user: user}
    before { api_authorization_header user.auth_token }

    context "when successfully updated" do
      before { patch :update, { user_id: user.id, id: product.id,
                                product: { title: "An TV" } } }

      it "renders the json reprentation for the updated user" do
        expect(json_response[:title]).to eql "An TV"
      end

      it { is_expected.to respond_with 200 }
    end

    context "when not successfully updated" do
      before { patch :update, { user_id: user.id, id: product.id,
                                product: { price: "Ten dollars" } } }

      it "renders the errors" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the error in the json" do
        expect(json_response[:errors][:price]).to include "is not a number"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    let(:user) { FactoryGirl.create :user }
    let(:product) { FactoryGirl.create :product, user: user}
    before do 
      api_authorization_header user.auth_token 
      delete :destroy, { user_id: user.id, id: product.id}
    end

    it { is_expected.to respond_with 204 }
  end
end
