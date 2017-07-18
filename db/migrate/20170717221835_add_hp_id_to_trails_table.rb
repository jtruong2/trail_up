class AddHpIdToTrailsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :trails, :hp_id, :integer
  end
end
