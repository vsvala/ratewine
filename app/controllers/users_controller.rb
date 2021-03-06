class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_user_is_admin, only: [:toggle_useractivity]

  # GET /users
  # GET /users.json
  def index
    # @wines = Wine.includes(:user.wines, :user.ratings).all
    @users = User.includes(:wines, :ratings).all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @approved_membership = Membership.confirmed
    @waitlist_membership = Membership.notconfirmed
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.admin = false
    @user.close = false

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if user_params[:username].nil? && @user == current_user && @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == current_user
      User.find(session[:user_id]).destroy
      session[:user_id] = nil
    end
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_useractivity
    user = User.find(params[:id])

    new_userstatus = user.close? ? false : true
    user.update_attribute :close, new_userstatus
    new_status = user.close? ? "close" : "open"

    redirect_to user, notice: "user account changed to #{new_status}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation) # :close, :admin
  end
end
