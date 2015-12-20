require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe "GET #index" do
    let(:current_user) { FactoryGirl.create :user }
    before do
      api_authorization_header current_user.auth_token
      4.times { FactoryGirl.create :order, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 orders from the user" do
      expect(json_response[:orders].size).to eql 4
    end

    it { is_expected.to respond_with 200 }
  end
end
