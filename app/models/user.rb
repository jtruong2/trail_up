class User < ApplicationRecord
  has_secure_password
  before_save :generate_slug
  mount_uploader :image, ImageUploader
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :slug, uniqueness: true
  has_one :picture, as: :imageable
  accepts_nested_attributes_for :picture

  enum role: %w(admin)

  def avatar
    if self.picture == nil
      'default_avatar.png'
    else
      self.picture.image
    end
  end

  def generate_slug
    self.slug = username.parameterize
  end

end
