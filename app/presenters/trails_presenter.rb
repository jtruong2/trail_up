class TrailsPresenter
  def initialize
    @results = HikingProjectService.search
  end

  def collection
    @trails ||= results[:trails].map do |trail|
      HPTrail.new(trail)
    end
  end

  private
    attr_reader :results
end