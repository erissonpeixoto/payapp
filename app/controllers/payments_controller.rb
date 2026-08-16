class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.where(user: current_user)
    @payments = @payments.where(status: params[:status_filter]) if params[:status_filter].present?

    if params[:category_id].present?
      @payments = @payments.left_joins(:expenses, :revenues)
        .where('expenses.category_id = :cid OR revenues.category_id = :cid', cid: params[:category_id])
        .distinct
    end

    if params[:period_start].present?
      start_date = parse_period_date(params[:period_start])
      @payments = @payments.where('payday >= ?', start_date) if start_date
    end

    if params[:period_end].present?
      end_date = parse_period_date(params[:period_end])
      @payments = @payments.where('payday <= ?', end_date.end_of_day) if end_date
    end

    @payments = @payments.includes(:expense_payments, :revenue_payments)
      .order(payday: :desc).paginate(:page => params[:page], :per_page => 5)
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
    @payment.user = current_user
    
    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Pagamento foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Pagamento foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Pagamento foi excluído com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.where(user: current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:payday, :status, :note,
        expense_payments_attributes: [:id, :expense_id, :value, :paid_at, :_destroy ],
        revenue_payments_attributes: [:id, :revenue_id, :value, :paid_at, :_destroy ])
    end

    # The period filter fields are plain query params (not run through AR
    # attribute type casting), submitted by native <input type="date">
    # fields -- always ISO 8601 (yyyy-mm-dd), never locale-dependent.
    def parse_period_date(str)
      Date.iso8601(str)
    rescue ArgumentError, TypeError
      nil
    end
end
