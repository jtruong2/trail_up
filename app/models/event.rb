class Event < ApplicationRecord
  belongs_to :user
  belongs_to :trail
  validates :name, :description, :date, presence: true
end
