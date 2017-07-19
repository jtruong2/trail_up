class Fitbit

  def initialize(user)
    @user = user
    @hosted = []
    @attended = []
    @dates = []
    @data = {}
  end

  def collect
    collect_events
    collect_host_dates
    collect_guest_dates
    collect_activity_data
  end


  private

    attr_reader :user, :hosted, :attended, :dates, :data

    def collect_activity_data
      output = []
      @dates.each do |date|
        formatted_date = format_date(date)
        response = FitbitService.new(formatted_date, user).get_activity_data
        output << FitbitPresenter.new(formatted_date, response)
      end
      output
    end

    def format_date(date)
      date.strftime("%Y-%m-%d")
    end

    def collect_events
      hosted.push(user.hosting.where(archived: true))
      attended.push(user.attending.where(archived: true))
    end

    def collect_host_dates
      @hosted[0].each do |event|
        dates << event.date
      end
    end

    def collect_guest_dates
      @attended[0].each do |event|
        dates << event.date
      end
    end


end
