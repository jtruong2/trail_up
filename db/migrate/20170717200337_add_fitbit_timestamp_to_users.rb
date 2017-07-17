class AddFitbitTimestampToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fitbit_refresh, :integer
  end
end
