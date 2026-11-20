class User < ApplicationRecord
  has_secure_password
  # hashes pw using bcrypt. store hashed pw in password_digest

  # ensure name and email arent blank and isnt already register
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
