
class Wine < ActiveRecord::Base 
  belongs_to :wineyard 
  has_many :ratings
end


