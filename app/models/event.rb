class Event < ApplicationRecord
  belongs_to :trail
  belongs_to :host, class_name: "User", foreign_key: "user_id"
  validates :name, :description, :date, presence: true
end
