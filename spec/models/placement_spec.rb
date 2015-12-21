require 'rails_helper'

RSpec.describe Placement, type: :model do
  let(:placement) { FactoryGirl.build :placement }
  subject { placement }

  it { is_expected.to respond_to :order_id }
  it { is_expected.to respond_to :product_id }
  it { is_expected.to respond_to :quantity }
  it { is_expected.to belong_to :order }
  it { is_expected.to belong_to :product }

  describe "#decrement_product_quantity!" do
    it "decrease the product quantity by the placement quantity" do
      product = placement.product
      expect{placement.decrement_product_quantity!}.to change{product.quantity}.by(-placement.quantity)
    end
  end
end
