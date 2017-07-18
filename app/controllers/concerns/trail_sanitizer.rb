module TrailSanitizer
  extend ActiveSupport::Concern

  def trail_params
    trail = JSON.parse(params[:trail], symbolize_names: true)
    trail[:description] = trail.delete :summary
    trail[:distance] = trail.delete :length
    trail[:longitude] = trail.delete :long
    trail[:latitude] = trail.delete :lat
    trail[:rating] = trail.delete :hp_rating
    trail.except(:hp_type, :hp_url, :hp_image, :google_coordinates)
  end
end
