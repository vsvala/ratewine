
class Wine < ActiveRecord::Base 
  belongs_to :wineyard 
  has_many :ratings, dependent: :destroy
  
  def to_s
    "#{name}, #{wineyard.name}"  
   #"Wine has #{ratings.count} #{pluralize_help}, average #{average_rating}" 

  end

  def average_rating
    # sum=0
    # ratings.each{ |a| sum+=a.score } 
    # sum/ratings.count
    # ratings.sum(:score)/ratings.count
    #ratings.average(:score)
    "Wine has #{ratings.count} #{pluralize_help}, average #{ratings.average(:score)}" 

  end


  def pluralize_help
    if ratings.count !=0
      ratings.count == 1 ? "rating" : "rating".pluralize
    end
  end


end