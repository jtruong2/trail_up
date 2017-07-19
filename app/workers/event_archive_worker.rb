class EventArchiveWorker
  def perform
    date = Date.today
    Event.all.each do |event|
      event.update_attribute(:archived, true) if event.date < date.end_of_day
      event.save
    end
  end
end