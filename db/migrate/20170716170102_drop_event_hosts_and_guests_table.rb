class DropEventHostsAndGuestsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :event_hosts
    drop_table :event_guests
  end
end
