class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /payments
  # GET /payments.json
  def index
    @search = Payment.ransack(params[:q])
    @payments = @search.result(distinct: true).order(:date).paginate(page: params[:page], per_page: 30)
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        @payment.update_statuses(@payment)
        @payment.update_total(@payment, @payment.invoices)
        format.html { redirect_to request.env["HTTP_REFERER"], notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        @payment.update_statuses(@payment)
        @payment.update_total(@payment, @payment.invoices)
        format.html { redirect_to request.env["HTTP_REFERER"], notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    @payment.update_statuses(@payment)
    respond_to do |format|
      format.html { redirect_to request.env["HTTP_REFERER"], notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:date, :amount, :reference, :customer_id, invoice_ids: [])
    end
end
