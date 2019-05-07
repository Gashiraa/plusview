class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @search = Invoice.paginate(page: params[:page], per_page: 10).ransack(params[:q])
    @invoices = @search.result(distinct: true).order(:status)
  end

  # GET /invoices/1
  # GET /invoices/1.json

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  def show
    @invoice = scope.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: t('invoice')+"_#{@invoice.id}",
               page_size: 'A4',
               template: "invoices/show.html.erb",
               layout: "pdf.html",
               orientation: "Portrait",
               encoding: 'utf8',
               lowquality: true,
               zoom: 1,
               dpi: 75
      end
    end
  end

  #
  def scope
    ::Invoice.all.includes(:wares)
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params_create)

    respond_to do |format|
      if @invoice.save
        @invoice.update_statuses_invoice(@invoice)
        @invoice.update_totals_invoice(@invoice, @invoice.projects, @invoice.wares)
        format.html {redirect_to invoices_url, notice: 'Invoice was successfully created.'}
        format.json {render :show, status: :created, location: @invoice}
      else
        format.html {render :new}
        format.json {render json: @invoice.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        @invoice.update_statuses_invoice(@invoice)
        @invoice.update_totals_invoice(@invoice, @invoice.projects, @invoice.wares)
        format.html {redirect_to invoices_url, notice: 'Invoice was successfully updated.'}
        format.json {render :show, status: :ok, location: @invoice}
      else
        format.html {render :edit}
        format.json {render json: @invoice.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.update_invoice_content_on_destroy(@invoice)
    @invoice.destroy
    respond_to do |format|
      format.html {redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:payment_id, :date, :status, :total, :customer_id, ware_ids: [], project_ids: [])
  end

  def invoice_params_create
    params.permit(:payment_id, :date, :status, :total, :customer_id, ware_ids: [], project_ids: [])
  end

end
