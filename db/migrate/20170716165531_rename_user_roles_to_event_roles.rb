class RenameUserRolesToEventRoles < ActiveRecord::Migration[5.1]
  def change
    rename_table :user_roles, :event_roles
  end
end
