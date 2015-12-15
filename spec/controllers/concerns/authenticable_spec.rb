require "rails_helper"

class Authentication < ActionController::Base
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe "#current_user" do
    let(:user) { FactoryGirl.create :user }
    before do
      request.headers["Authorization"] = user.auth_token
      authentication.stub(:request).and_return(request)
    end

    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eql user.auth_token
    end
  end

  describe "#authenticate_with_token" do
    let(:user) { FactoryGirl.create :user }
    before do
      authentication.stub(:current_user).and_return(nil)
      response.stub(:response_code).and_return(401)
      response.stub(:body).and_return({"errors" => "Not authenticated"}.to_json)
      authentication.stub(:response).and_return(response)
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it { is_expected.to respond_with 401 }
  end

  describe "#user_signed_in?" do
    let(:user) { FactoryGirl.create :user } 

    context "when there is a user on 'session'" do
      before do
        authentication.stub(:current_user).and_return(user)
      end

      it { expect(authentication.user_signed_in?).to eql true }
    end

    context "when there is no user on 'session'" do
      before do
        authentication.stub(:current_user).and_return(nil)
      end

      it { expect(authentication.user_signed_in?).to eql false }
    end
  end
  
end
