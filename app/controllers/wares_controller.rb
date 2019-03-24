class WaresController < ApplicationController
  before_action :set_ware, only: %i[show edit update destroy]

  # GET /wares
  # GET /wares.json
  def index
    @search = Ware.ransack(params[:q])
    @wares = @search.result(distinct: true)
  end

  # GET /wares/1
  # GET /wares/1.json
  def show; end

  # GET /wares/new
  def new
    @ware = Ware.new
  end

  # GET /wares/1/edit
  def edit; end

  # POST /wares
  # POST /wares.json
  def create
    @ware = Ware.new(ware_params_create)

    respond_to do |format|
      if @ware.save
        format.html { redirect_to wares_url + '#new', notice: t('Ware was successfully created.') }
        format.json { render :show, status: :created, location: @ware }
      else
        format.html { render :new }
        format.json { render json: @ware.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wares/1
  # PATCH/PUT /wares/1.json
  def update
    respond_to do |format|
      if @ware.update(ware_params)
        @ware.project.update_total(@ware.project)
        format.html { redirect_to wares_url, notice: t('Ware was successfully updated.') }
        format.json { render :show, status: :ok, location: @ware }
      else
        format.html { render :edit }
        format.json { render json: @ware.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wares/1
  # DELETE /wares/1.json
  def destroy
    @ware.destroy
    respond_to do |format|
      format.html { redirect_to wares_url, notice: t('Ware was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ware
    @ware = Ware.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ware_params
    params.require(:ware).permit(:project_id, :invoice_id, :customer_id, :quotation_id, :name, :comment, :quantity, :provider_discount, :margin, :unit_price, :status, :tva_rate, :total_cost, :total_gross, :provider_name, :provider_discount, :provider_net, :provider_invoice, :ware_name)
  end

  def ware_params_create
    params.permit(:project_id, :invoice_id, :customer_id, :quotation_id, :name, :comment, :quantity, :provider_discount, :margin, :unit_price, :status, :tva_rate, :total_cost, :total_gross, :provider_name, :provider_discount, :provider_net, :provider_invoice, :ware_name)
  end
end
