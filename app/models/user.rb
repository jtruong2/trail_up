class User < ApplicationRecord
  has_secure_password
  before_save :generate_slug

  mount_uploader :image, ImageUploader

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  has_one :picture, as: :imageable
  has_many :event_roles
  has_many :events, through: :event_roles

  accepts_nested_attributes_for :picture

  enum role: %w(admin)


  def avatar
    if picture[:image].nil?
      'default_avatar.png'
    else
      picture.image
    end
  end

  def generate_slug
    self.slug = username.parameterize if username
  end

  def attending
    filter_by_role("guest")
  end

  def hosting
    filter_by_role("host")
  end

  def filter_by_role(role)
    events.joins(:event_roles).where(event_roles: {role: "#{role}"})
  end
end
