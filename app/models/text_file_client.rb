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
    thing = CSV.read("placeholder_clubs.txt")
  end

  def update_avatar_list
    owners = Owner.all
    File.open("avatar_list.txt", "w") do |file|
      owners.each do |owner|
        file.puts "#{owner.name},#{owner.avatar}"
      end
    end
  end

  def read_avatar_list
    avatar_list = []
    File.open("avatar_list.txt", "r") do |file|
      file.each_line do |line|
        avatar_list << line
      end
    end
    return avatar_list
  end

  def get_champ_name
    File.open("champ.txt", "r") do |file|
      file.each_line do |line|
        return line
      end
    end
  end

  def set_champ_name(name)
    File.open("champ.txt", "w") do |file|
      file.print name
    end
  end

end
