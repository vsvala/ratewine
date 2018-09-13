class RatingsController < ApplicationController
  before_action :set_rating, only: [:show]

  def new
    @rating = Rating.new
    @wines = Wine.all
  end

  def create
    Rating.create params.require(:rating).permit(:score, :wine_id)
    redirect_to ratings_path
  end



  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all	
	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:score)
    end
    
end
