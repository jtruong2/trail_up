class FitbitPresenter
attr_reader :date, :data
  def initialize(date = nil, data = nil)
    @date = date
    @data = data
  end

  def partial
    return "error" if date == nil && data == nil
    return "error" if data[:errors].class == Array
    return "authenticated" if date != nil && data != nil
  end
end
