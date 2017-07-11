class HPTrail
  attr_reader :id, :name, :summary, :difficulty, :location, :length, :long, :lat, :hp_image, :hp_rating 
  
  def initialize(params={})
    @id = params[:id]
    @name = params[:name]
    @summary = params[:summary]
    @difficulty = params[:difficulty]
    @location = params[:location]
    @length = params[:length]
    @long = params[:longitude]
    @lat = params[:latitude]
    @hp_type = params[:type]
    @hp_url = params[:url]
    @hp_rating = params[:stars]
    @hp_image = params[:imgSmall]
  end

  def google_coordinates
    {lng: long, lat: lat}
  end
end