require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { FactoryGirl.build :order}
  subject { order }

  it { is_expected.to respond_to(:total) }
  it { is_expected.to respond_to(:user_id) }

  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to belong_to :user }

  it { is_expected.to have_many(:placements) }
  it { is_expected.to have_many(:products).through(:placements) }

  describe "#set_total!" do
    let(:product1) { FactoryGirl.create :product, price: 100 }
    let(:product2) { FactoryGirl.create :product, price: 99 }
    let(:order) { FactoryGirl.build :order, product_ids: [product1.id, product2.id] }
    it "returns the total amount to pay" do
      expect{order.set_total!}.to change{order.total}.from(0).to(199)
    end
  end
end
