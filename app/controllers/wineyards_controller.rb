class WineyardsController < ApplicationController
  before_action :set_wineyard, only: [:show, :edit, :update, :destroy]

  # GET /wineyards
  # GET /wineyards.json
  def index
    @wineyards = Wineyard.all
  end

  # GET /wineyards/1
  # GET /wineyards/1.json
  def show
  end

  # GET /wineyards/new
  def new
    @wineyard = Wineyard.new
  end

  # GET /wineyards/1/edit
  def edit
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
      format.html { redirect_to wineyards_url, notice: 'Wineyard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wineyard
      @wineyard = Wineyard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wineyard_params
      params.require(:wineyard).permit(:name, :year)
    end
end
