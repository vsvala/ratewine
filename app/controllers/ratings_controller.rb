# frozen_string_literal: true

class RatingsController < ApplicationController
  extend Top
  before_action :set_rating, only: [:show]

  def new
    @rating = Rating.new
    @wines = Wine.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :wine_id)
    @rating.user = current_user
    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating
      # session[:last_rating] = "#{rating.wine.name} #{rating.score} points"
      redirect_to user_path current_user
    else
      @wines = Wine.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end

  # GET /ratings
  # GET /ratings.json
  def index
    # Rails.cache.write("wine top 3", Wine.top(3)) if cache_does_not_contain_data_or_it_is_too_old
    # @top_wines = Rails.cache.read "wine top 3"

    # @ratings = Rating.recent
    # @wines = Wine.top(3)
    # @styles = Style.top(3)
    # @wineyard = Wineyard.top(3)
    # @users = User.top(3)

    @top_users = User.top 3
    @top_wines = Wine.top 3
    @top_wineyards = Wineyard.top 3
    @recent_ratings = Rating.recent
    @active_ratings = Rating.active
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
