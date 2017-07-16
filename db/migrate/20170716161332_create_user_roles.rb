class CreateUserRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_roles do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
