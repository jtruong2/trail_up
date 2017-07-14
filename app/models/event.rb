class Event < ApplicationRecord
  belongs_to :trail
  validates :name, :description, :date, presence: true

  has_many :event_guests
  has_many :guests, :through => :event_guests, source: :guest

  has_many :event_hosts
  has_many :hosts, :through => :event_hosts, source: :host
end
