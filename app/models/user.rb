class User < ApplicationRecord
  attr_accessor :login_meetup

  validates :email, presence: true, uniqueness: true, unless: :login_meetup
  validates :username, presence: true, uniqueness: true, unless: :login_meetup
  validates :slug, uniqueness: true
  has_one :picture, as: :imageable, dependent: :destroy
  has_many :event_roles, dependent: :destroy
  has_many :events, through: :event_roles

  has_secure_password
  before_save :generate_slug

  mount_uploader :image, ImageUploader


  accepts_nested_attributes_for :picture

  enum role: %w(admin)

  def to_param
    slug
  end

  def avatar
    if picture.nil? || picture[:image].nil?
      'default_avatar.png'
    else
      picture.image
    end
  end

  def generate_slug
    self.slug = username.parameterize if username
  end

  def partials

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

  def event_status(event_id)
    return "host" unless hosting.where(id: event_id).empty?
    return "guest" unless attending.where(id: event_id).empty?
    return "authorized"
  end

  def self.create_with_omniauth(auth)
    create(
      login_meetup: true,
      provider: auth["provider"],
      uid: auth["uid"],
      username: auth["info"]["name"],
      password: SecureRandom.hex(8)
    )
  end

  def self.from_google_omniauth(auth)
    find_or_create_by(uid: auth[:uid][9...-1]) do |user|
      user.uid        = auth["uid"][9...-1]
      user.username   = auth["info"]["first_name"]
      user.email      = auth["info"]["email"]
      user.image      = auth["info"]["image"]
      user.password   = "password"
      user.provider   = auth["provider"]
    end
  end

  def self.from_twitter_omniauth(auth)
    find_or_create_by(uid: auth[:uid]) do |user|
      user.uid        = auth["uid"]
      user.username   = "#{auth["info"]["name"]} "
      user.email      = "#{auth['info']['nickname']}@noemail.com"
      user.image      = auth["info"]["image"]
      user.password   = "password"
      user.provider   = auth["provider"]
    end
  end
end
