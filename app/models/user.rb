class User < ApplicationRecord
  has_secure_password
  mount_uploader :image, ImageUploader
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_one :picture, as: :imageable
  accepts_nested_attributes_for :picture

  def avatar
    if self.picture == nil
      'default_avatar.png'
    else
      self.picture.image
    end
  end

end
