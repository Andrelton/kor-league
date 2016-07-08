class Owner < ActiveRecord::Base
  has_many :owner_clubs
  has_many :clubs, through: :owner_clubs, source: :club
end
