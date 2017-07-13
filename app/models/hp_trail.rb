class HPTrail
  attr_reader :hp_id, :name, :summary, :difficulty, :location, :length, :long, :lat, :hp_image, :hp_rating, :google_coordinates 
  
  def initialize(params={})
    @hp_id = params[:id]
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
    @google_coordinates = google_coordinates
  end

  def google_coordinates
    {lng: long, lat: lat}
  end

  def difficulty
    @difficulty.gsub!('blueBlack', 'Blue-Black')
    @difficulty.capitalize!
  end

  def length
    "#{@length} miles"
  end
  
  
end