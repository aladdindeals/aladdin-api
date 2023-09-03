class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  enum :role, [:non_admin, :admin], _suffix: true
  validates :phone_number, presence: true, uniqueness: true
  validates_presence_of :first_name, :last_name
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: Proc.new { |usr| usr.email.present? }
  include BCrypt

  def grant_access
    pw            = SecureRandom.urlsafe_base64
    self.password = pw
    self.save
    # send_welcome_email_async(pw) if saved
  end

  def name
    first_name + last_name
  end

end
