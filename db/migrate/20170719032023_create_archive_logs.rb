class CreateArchiveLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :archive_logs do |t|
      t.timestamps
    end
  end
end
