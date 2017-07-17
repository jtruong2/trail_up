class TrailsPresenter

  def initialize(search_params)
    @results ||= HikingProjectService.search(search_params)
  end

  def collection
    @trails ||= results[:trails].map do |trail|
      HPTrail.new(trail)
    end
  end

  private
    attr_reader :results
end