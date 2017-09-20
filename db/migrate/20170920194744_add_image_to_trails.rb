class AddImageToTrails < ActiveRecord::Migration[5.1]
  def change
    add_column :trails, :image, :string
  end
end
