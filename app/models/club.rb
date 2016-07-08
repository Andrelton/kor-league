class Club < ActiveRecord::Base
  belongs_to :country

  has_many :owner_clubs
  has_many :owners, through: :owner_clubs, source: :owner

  validates :fd_name, uniqueness: true
  # add validations
end
