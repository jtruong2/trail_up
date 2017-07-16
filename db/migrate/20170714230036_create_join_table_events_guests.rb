class CreateJoinTableEventsGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :event_guests do |t|
      t.references :event, foreign_key: true
      t.references :guest
    end
  end
end
