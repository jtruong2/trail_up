class CreateJoinTableEventsHosts < ActiveRecord::Migration[5.1]
  def change
    create_table :event_hosts do |t|
      t.references :event, foreign_key: true
      t.references :host
    end
  end
end
