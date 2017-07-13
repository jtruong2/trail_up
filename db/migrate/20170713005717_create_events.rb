class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :trail, foreign_key: true
      t.string :name
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
