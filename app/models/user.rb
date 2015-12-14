class User < ActiveRecord::Base
  before_validation :downcase_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
    def downcase_email
      self.email = self.email.downcase if self.email.present?
    end
end
