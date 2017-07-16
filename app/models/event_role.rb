class EventRole < ApplicationRecord
  validates :role, presence: :true

  belongs_to :user
  belongs_to :event
  
  enum role: [:guest, :host]
end
