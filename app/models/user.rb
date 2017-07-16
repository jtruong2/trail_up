class User < ApplicationRecord
  has_secure_password
  before_save :generate_slug

  mount_uploader :image, ImageUploader

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  has_one :picture, as: :imageable

  has_many :event_guests, :foreign_key => 'guest_id'
  has_many :attending, :through => :event_guests, source: :event

  has_many :event_hosts, :foreign_key => 'host_id'
  has_many :hosting, :through => :event_hosts, source: :event

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
    self.slug = username.parameterize if username
  end

  def self.find_or_create_by_auth(auth)
    binding.pry
  end

end
