class EventGuest < ApplicationRecord
  belongs_to :event
  belongs_to :guest, :class_name => 'User', :foreign_key => 'guest_id'
end