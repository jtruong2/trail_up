class CreateDifficulty < ActiveRecord::Migration[5.1]
  def change
    create_table :difficulties do |t|
      t.string :rating
    end
  end
end
