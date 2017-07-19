class CreateDifficultyTable < ActiveRecord::Migration[5.1]
  def change
    create_table :difficulty_tables do |t|
      t.string :rating
    end
  end
end
