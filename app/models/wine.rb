
class Wine < ActiveRecord::Base 
  belongs_to :wineyard 
  has_many :ratings
  
  def to_s
   "Wine has #{ratings.count} #{"rating".pluralize(2)}, average #{average_rating}" 

  end

  def average_rating
    # sum=0
    # ratings.each{ |a| sum+=a.score } 
    # sum/ratings.count
    # ratings.sum(:score)/ratings.count
    ratings.average(:score)
  end


end


