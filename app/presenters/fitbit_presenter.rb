class FitbitPresenter
attr_reader :date, :data
  def initialize(date, data)
    @date = date
    @data = data
  end
end
