# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :set_rating, only: [:show]

  def new
    @rating = Rating.new
    @wines = Wine.all
  end

  def create
    rating=Rating.new params.require(:rating).permit(:score, :wine_id)
    rating.user=current_user
    rating.save
    #session[:last_rating] = "#{rating.wine.name} #{rating.score} points"
    redirect_to current_user
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to user_path(current_user)
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
