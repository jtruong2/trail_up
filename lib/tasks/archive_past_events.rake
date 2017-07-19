desc "Archive past evets after event date"
task :archive_events => :environment do
  puts "archiving today's events"
    EventArchiveWorker.new.perform
  puts "event's archived"
end
