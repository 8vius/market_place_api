class User < ActiveRecord::Base
  before_create :generate_authentication_token!

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products, dependent: :destroy

  validates :email, uniqueness: true
  validates :auth_token, uniqueness: true

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
