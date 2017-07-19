class ArchiveLog <ApplicationRecord

  before_create :check_dates

  def check_dates
    binding.pry
  end
end
