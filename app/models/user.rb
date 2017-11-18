class User < ApplicationRecord
  validates :username, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :require_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def require_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def self.find_by_cred(username, password)
    user = User.find_by(username: username)
    if (user && user.is_password?(password))
      return user
    end
    return nil
  end

end
