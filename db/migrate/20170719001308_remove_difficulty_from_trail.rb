class RemoveDifficultyFromTrail < ActiveRecord::Migration[5.1]
  def change
    remove_column :trails, :difficulty, :remove
  end
end
