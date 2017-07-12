class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  before_save :generate_slug

  def generate_slug
    self.slug = username.parameterize
  end

end
