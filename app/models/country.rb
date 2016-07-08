class Country < ActiveRecord::Base
  has_many :clubs

  # add validations
end
