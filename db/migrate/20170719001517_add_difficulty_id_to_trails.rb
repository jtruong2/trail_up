class AddDifficultyIdToTrails < ActiveRecord::Migration[5.1]
  def change
    add_reference :trails, :difficulty, foreign_key: true
  end
end
