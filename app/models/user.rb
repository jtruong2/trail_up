class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_one :picture, as: :imageable

  def avatar
    if self.picture == nil
      image_tag('default_avatar.png')
    else
      image_tag("#{self.picture}")
    end
  end

end
