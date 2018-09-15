class Wineyard < ActiveRecord::Base
  include RatingAverage
  has_many :wines, dependent: :destroy
  has_many :ratings, through: :wines

end



