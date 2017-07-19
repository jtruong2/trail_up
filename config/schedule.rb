# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}


every 1.day, :at => '11:59 pm' do
  rake 'archive_events'
end


set :environment, "test"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.day, :at => '11:59 pm' do
  rake "archive_events"
end