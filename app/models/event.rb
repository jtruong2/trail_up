class Event < ApplicationRecord
  belongs_to :host, class_name: "User", foreign_key: "user_id"
  belongs_to :trail
  validates :name, :description, :date, presence: true
end
