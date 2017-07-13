class TrailsPresenter
  def initialize(location_params)
    @results ||= HikingProjectService.search(location_params)
  end

  def collection
    @trails ||= results[:trails].map do |trail|
      HPTrail.new(trail)
    end
  end

  private
    attr_reader :results
end