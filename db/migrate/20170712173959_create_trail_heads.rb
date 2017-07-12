class CreateTrailHeads < ActiveRecord::Migration[5.1]
  def change
    create_table :trail_heads do |t|
      t.string :lat
      t.string :long
      t.string :name
    end
  end
end
