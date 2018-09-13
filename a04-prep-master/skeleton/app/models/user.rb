class User < ApplicationRecord
  validates :username, presence: {message: 'can\'t be blank'}, uniqueness: true
  validates :password_digest, presence: {message: 'can\'t be blank'}
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :links,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Link

  has_many :comments,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Comment

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

end
