
class Wine < ActiveRecord::Base 
  belongs_to :wineyard 
  has_many :ratings
  
  def to_s
   "Wine has #{ratings.count} #{pluralize_help}, average #{average_rating}" 

  end

  def average_rating
    # sum=0
    # ratings.each{ |a| sum+=a.score } 
    # sum/ratings.count
    # ratings.sum(:score)/ratings.count
    ratings.average(:score)
  end

  def pluralize_help
    if ratings.count !=0
      ratings.count == 1 ? "rating" : "rating".pluralize
    end
  end

end