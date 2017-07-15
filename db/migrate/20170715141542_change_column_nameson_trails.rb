class ChangeColumnNamesonTrails < ActiveRecord::Migration[5.1]
  def change
    rename_column :trails, :long, :longitude
    rename_column :trails, :lat, :latitude
  end
end
