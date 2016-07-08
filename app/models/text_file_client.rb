require 'csv'

class TextFileClient
  def get_club_assignments
    CSV.read("club_assignments.txt")
  end

  def get_club_name_conversions
    CSV.read("club_name_conversions.txt")
  end

end
