require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.create(:user, :id => 1) }
  subject { @user } 

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
end
