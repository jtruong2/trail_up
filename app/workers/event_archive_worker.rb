class EventArchiveWorker
  def perform
    Event.all.each do |event|
      event.update_attribute(:archived, true) if 2.days.ago > event.date
      event.save
    end
  end
end
