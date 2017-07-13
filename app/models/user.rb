class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_one :picture, as: :imageable

  def avatar
    if self.picture == nil
      'default_avatar.png'
    else
      self.picture
    end
  end

end
