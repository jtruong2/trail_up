module Sanitizer
  extend ActiveSupport::Concern

  def sanitize_query(query)
    query.gsub(/\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/, '')
  end
end
