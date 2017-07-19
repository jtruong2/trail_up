class DropArchiveLogsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :archive_logs
  end
end
