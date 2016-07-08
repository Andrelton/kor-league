class League < ActiveRecord::Base
  has_many :clubs

  # add validations
end
