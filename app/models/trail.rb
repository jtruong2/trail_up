class Trail < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, :difficulty, :location, :distance, :rating, presence: true
end
