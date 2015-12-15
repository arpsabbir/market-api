require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "POST #create" do
    let(:user) { FactoryGirl.create :user }

    context "when the credentials are correct" do
      let(:credentials) { { email: user.email, password: "12345678" } } 
      before { post :create, { session: credentials } }

      it "returns the user record corresponding to the give credentials" do
        user.reload
        expect(json_response[:auth_token]).to eql user.auth_token 
      end

      it { should respond_with 200 }
    end

    context "when the credentials are not correct" do
      let(:credentials) { { email: user.email, password: "invalid" } }
      before { post :create, { session: credentials } }

      it "returns a json with an error" do
        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it { should respond_with 422 }
    end
  end
end
