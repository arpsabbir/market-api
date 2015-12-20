class Order < ActiveRecord::Base
  validates :user_id, presence: true
  before_validation :set_total!
  belongs_to :user

  has_many :placements
  has_many :products, through: :placements

  def set_total!
    self.total = products.map(&:price).sum
  end
end
