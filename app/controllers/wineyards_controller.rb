# frozen_string_literal: true
# comment

require 'digest/md5'
class WineyardsController < ApplicationController
  before_action :set_wineyard, only: %i[show edit update destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :ensure_that_user_is_admin, only: [:destroy]

  # GET /wineyards
  # GET /wineyards.json
  def index
    @active_wineyards = Wineyard.active
    @retired_wineyards = Wineyard.retired
    # @wineyards = Wineyard.all
  end

  # GET /wineyards/1
  # GET /wineyards/1.json
  def show; end

  # GET /wineyards/new
  def new
    @wineyard = Wineyard.new
  end

  # GET /wineyards/1/edit
  def edit;
  end

  # POST /wineyards
  # POST /wineyards.json
  def create
    @wineyard = Wineyard.new(wineyard_params)

    respond_to do |format|
      if @wineyard.save
        format.html { redirect_to @wineyard, notice: 'Wineyard was successfully created.' }
        format.json { render :show, status: :created, location: @wineyard }
      else
        format.html { render :new }
        format.json { render json: @wineyard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wineyards/1
  # PATCH/PUT /wineyards/1.json
  def update
    respond_to do |format|
      if @wineyard.update(wineyard_params)
        format.html { redirect_to @wineyard, notice: 'Wineyard was successfully updated.' }
        format.json { render :show, status: :ok, location: @wineyard }
      else
        format.html { render :edit }
        format.json { render json: @wineyard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wineyards/1
  # DELETE /wineyards/1.json
  def destroy
    @wineyard.destroy
    respond_to do |format|
      format.html { redirect_to wineyards_url, notice: 'Wineyard destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    wineyard = Wineyard.find(params[:id])
    wineyard.update_attribute :active, (not wineyard.active)

    new_status = wineyard.active? ? "active" : "retired"

    redirect_to wineyard, notice: "wineyard activity status changed to #{new_status}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wineyard
    @wineyard = Wineyard.find(params[:id])
  end

  # Never trust parameters fromthescaryinternet, onlyallowthewhitelistthrough
  def wineyard_params
    params.require(:wineyard).permit(:name, :year, :active)
  end
end
