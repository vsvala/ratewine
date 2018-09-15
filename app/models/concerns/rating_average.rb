module RatingAverage
    extend ActiveSupport::Concern
   
    def average_rating
        # sum=0
        # ratings.each{ |a| sum+=a.score } 
        # sum/ratings.count
        # ratings.sum(:score)/ratings.count
        #ratings.average(:score)
        "Has #{ratings.count} #{pluralize_help}, average #{ratings.average(:score)}" 
    
      end 
    
      def pluralize_help
        if ratings.count !=0
          ratings.count == 1 ? "rating" : "rating".pluralize
        end
      end

   end