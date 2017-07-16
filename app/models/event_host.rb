class EventHost < ApplicationRecord
  belongs_to :event
  belongs_to :host, :class_name => 'User', :foreign_key => 'host_id'
end