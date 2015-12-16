class User < ActiveRecord::Base
  validates :auth_token, uniqueness: true
  before_validation :downcase_email
  before_create :generate_authentication_token!
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :products, dependent: :destroy

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  private
    def downcase_email
      self.email = self.email.downcase if self.email.present?
    end
end
