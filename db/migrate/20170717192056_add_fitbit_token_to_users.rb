class AddFitbitTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fitbit_token, :string
  end
end
