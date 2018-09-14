class Wineyard < ActiveRecord::Base
  has_many :wines, dependent: :destroy
  has_many :ratings, through: :wines


  def average_rating
    "Has #{ratings.count} #{pluralize_help}, average #{ratings.average(:score)}" 
  end

  def pluralize_help
    if ratings.count !=0
      ratings.count == 1 ? "rating" : "rating".pluralize
    end
  end


end



