class CreateTrails < ActiveRecord::Migration[5.1]
  def change
    create_table :trails do |t|
      t.string :name
      t.string :description
      t.string :difficulty
      t.string :location
      t.float :distance
      t.float :rating
      t.float :long
      t.float :lat

      t.timestamps
    end
  end
end
