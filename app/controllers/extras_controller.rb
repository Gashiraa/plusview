class ExtrasController < ApplicationController
  before_action :set_extra, only: [:show, :edit, :update, :destroy]

  # GET /extras
  # GET /extras.json
  def index
    @search = Extra.paginate(page: params[:page], per_page: 10).ransack(params[:q])
    @extras = @search.result(distinct: true)
  end

  # GET /extras/1
  # GET /extras/1.json
  def show
  end

  # GET /extras/new
  def new
    @extra = Extra.new
    respond_to(&:js)
  end

  # GET /extras/1/edit
  def edit
    @extra = Extra.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /extras
  # POST /extras.json
  def create
    @extra = Extra.new(extra_params)
    respond_to do |format|
      if @extra.save
        format.html { redirect_to extras_path, notice: 'Extra was successfully created.' }
        format.json { render :show, status: :created, location: @extra }
      else
        format.html { render :new }
        format.json { render json: @extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extras/1
  # PATCH/PUT /extras/1.json
  def update
    respond_to do |format|
      if @extra.update(extra_params)
        format.html { redirect_to extras_path, notice: 'Extra was successfully created.' }
        format.json { render :show, status: :ok, location: @extra }
      else
        format.html { render :edit }
        format.json { render json: @extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extras/1
  # DELETE /extras/1.json
  def destroy
    @extra.destroy
    respond_to do |format|
      format.html { redirect_to extras_path, notice: 'Extra was successfully created.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra
      @extra = Extra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extra_params
      params.require(:extra).permit(:name, :unit, :unit_price, :tva_rate)
    end
end
