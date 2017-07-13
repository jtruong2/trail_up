class Coordinates
  attr_reader :orig_lat, :orig_lng, :dest_lat, :dest_lng
  def initialize(coords)
    @orig_lat   = coords[:orig_lat]
    @orig_lng   = coords[:orig_lng]
    @dest_lat   = coords[:dest_lat]
    @dest_lng   = coords[:dest_lng]
  end
end