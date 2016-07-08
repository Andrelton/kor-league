class PrettyClubName < ActiveRecord::Base
  validates :name, uniqueness: true
end
