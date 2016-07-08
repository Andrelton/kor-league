require 'csv'

class TextFileClient
  def get_club_name_conversions
    CSV.read("club_name_conversions.txt")
  end

  def get_club_assignments
    owner_clubs = {}
    CSV.foreach("club_assignments.txt") do |assignment|
      owner_clubs[assignment[0]] = assignment[1..-1]
    end
    return owner_clubs
  end

  def get_placeholder_clubs
    thing = CSV.read("placeholder_clubs.txt").flatten
  end

end
