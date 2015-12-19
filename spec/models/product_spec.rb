require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryGirl.create :product }
  subject { product } 

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:price) }
  it { is_expected.to respond_to(:published) }
  it { is_expected.to respond_to(:user_id) }

  it { expect(product.published).to be false }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to belong_to :user}

  describe ".filter_by_title" do
    let(:product1) { FactoryGirl.create :product, title: "A plasma TV" } 
    let(:product2) { FactoryGirl.create :product, title: "Fastest Laptop" } 
    let(:product3) { FactoryGirl.create :product, title: "CD Player" } 
    let(:product4) { FactoryGirl.create :product, title: "LCD TV" } 

    context "when a 'TV' title pattern is sent" do

      it "returns the products matching" do
        expect(Product.filter_by_title("TV")).to match_array([product1, product4]) 
      end
    end
  end

  describe "comparing price" do
    let(:product1) { FactoryGirl.create :product, price: 100 } 
    let(:product2) { FactoryGirl.create :product, price: 50 } 
    let(:product3) { FactoryGirl.create :product, price: 150 } 
    let(:product4) { FactoryGirl.create :product, price: 99 } 

    it "returns the products which are above or equal to the price" do
      expect(Product.above_or_equal_to_price(100)).to match_array([product1, product3]) 
    end

    it "returns the products which are below or equal to the price" do
      expect(Product.below_or_equal_to_price(100)).to match_array([product1, product2, product4]) 
    end

    it "returns the most updated records" do
      product2.touch
      product3.touch
      expect(Product.recent).to match_array([product3, product2, product4, product1])
    end
  end
end
