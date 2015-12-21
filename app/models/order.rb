class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates_with EnoughProductsValidator
  before_validation :set_total!
  belongs_to :user

  has_many :placements
  has_many :products, through: :placements

  def set_total!
    self.total = products.map(&:price).sum
  end

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |id_and_quantity|
      id, quantity = id_and_quantity
      self.placements.build(product_id: id, quantity: quantity)
    end
  end
end
