module TrailSanitizer
  extend ActiveSupport::Concern

  def trail_params
    trail = JSON.parse(params[:trail], symbolize_names: true)
    difficulty = Difficulty.find_by(rating: trail[:difficulty].capitalize)
    trail[:description] = trail.delete :summary
    trail[:difficulty_id] = trail.delete :difficulty
    trail[:difficulty_id] = difficulty.id
    trail[:distance] = trail.delete :length
    trail[:longitude] = trail.delete :long
    trail[:latitude] = trail.delete :lat
    trail[:rating] = trail.delete :hp_rating
    trail.except(:hp_type, :hp_url, :hp_image, :google_coordinates)
  end
end
