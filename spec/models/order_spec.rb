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
    let(:product2) { FactoryGirl.create :product, price: 90 }

    let(:placement1) { FactoryGirl.build :placement, product: product1, quantity: 3 } 
    let(:placement2) { FactoryGirl.build :placement, product: product2, quantity: 15 }

    let(:order) { FactoryGirl.build :order } 

    it "returns the total amount to pay" do
      order.placements << placement1
      order.placements << placement2
      expect{order.set_total!}.to change{order.total}.from(0).to(1650)
    end
  end

  describe "#build_placements_with_product_ids_and_quantities" do
    let(:product1) { FactoryGirl.create :product, price: 100, quantity: 5 }
    let(:product2) { FactoryGirl.create :product, price: 90, quantity: 10 }
    let(:product_ids_and_quantities) { [[product1.id, 2], [product2.id, 3]] } 

    it "builds 2 placements for the order" do
      expect{order.build_placements_with_product_ids_and_quantities(product_ids_and_quantities)}.to change{order.placements.size}.from(0).to(2)
    end
  end

  describe "#valid?" do
    let(:product1) { FactoryGirl.create :product, price: 100, quantity: 5 }
    let(:product2) { FactoryGirl.create :product, price: 90, quantity: 10 }

    let(:placement1) { FactoryGirl.build :placement, product: product1, quantity: 3 } 
    let(:placement2) { FactoryGirl.build :placement, product: product2, quantity: 15 } 

    let(:order) { FactoryGirl.build :order } 

    it "becomes invalid due to insufficient products" do
      order.placements << placement1
      order.placements << placement2
      expect(order).to_not be_valid
    end
  end
end
