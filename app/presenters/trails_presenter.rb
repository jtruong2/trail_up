class TrailsPresenter
  def initialize(coords={ :lat=> 39.742043, :lng=> -104.991531 })
    @results ||= HikingProjectService.search(coords={ :lat=> 39.742043, :lng=> -104.991531 })
  end

  def collection
    @trails ||= results[:trails].map do |trail|
      HPTrail.new(trail)
    end
  end

  private
    attr_reader :results
end