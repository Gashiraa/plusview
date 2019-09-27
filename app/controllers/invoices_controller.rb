# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy]
  load_and_authorize_resource
  # GET /invoices
  # GET /invoices.json
  def index
    @search = Invoice.ransack(params[:q])
    @invoices = @search.result(distinct: true).order(created_at: :desc).paginate(page: params[:page], per_page: 30)
  end

  # GET /invoices/1
  # GET /invoices/1.json

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    respond_to(&:js)
  end

  def show
    @company = Company.first
    @invoice = scope.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "plusview sprl-facture" + @invoice.id.to_s,
               page_size: 'A4',
               template: 'invoices/show.html.erb',
               layout: 'pdf.html',
               encoding: 'utf8',
               show_as_html: params.key?('debug'),
               :margin => {:bottom => 35},
               footer: {
                   html: {
                       template: 'layouts/pdf_footer.html.erb'
                   },
               }
      end
    end
  end

  def scope
    ::Invoice.all.includes(:wares)
  end

  # GET /invoices/1/edit
  def edit;
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.display_number = get_next_invoice_number
    respond_to do |format|
      if @invoice.save
        @invoice.update_statuses_invoice(@invoice)
        @invoice.update_totals_invoice(@invoice, @invoice.projects, @invoice.wares)
        format.html { redirect_to invoice_path(@invoice.id, :format => :pdf), notice: 'Invoice was successfully created.' }
      else
        format.html { render :new }
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
        format.html { redirect_to invoices_url, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.update_invoice_content_on_destroy(@invoice)
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def paid
    respond_to do |format|
      if @invoice.update(status: 1)
        @invoice.update_statuses_invoice(@invoice)
        @invoice.update_totals_invoice(@invoice, @invoice.projects, @invoice.wares)
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('project_update_success') }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:payment_id, :date, :status, :total, :display_number, :customer_id, ware_ids: [], project_ids: [])
  end

  def get_next_invoice_number

    max_number = Invoice.maximum("display_number") || 0
    for i in 190056..max_number
      if Invoice.exists?(display_number: i)
        next
      else
        return i
      end
    end
    return 1 + max_number
  end
end