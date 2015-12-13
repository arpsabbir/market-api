require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }
  subject { @user } 

  it "should respond to user attributes " do
    should respond_to(:email)
    should respond_to(:password)
    should respond_to(:password_confirmation)
    should be_valid
  end
end
