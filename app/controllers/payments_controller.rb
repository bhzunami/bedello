class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @payments = Payment.all   
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      flash[:success] = "Zahlungsart #{@payment.name} gespeichert."
      redirect_to @payment
    else
      render action: 'new'
    end
  end


  def new
    @payment = Payment.new
  end

  # GET /payment/1/edit
  def edit
  end

  def update
    if @payment.update(payment_params)
      flash[:success] = "Zahlungsart #{@payment.name} aktualisiert."
      redirect_to payments_path
    else
      render action: 'edit'
    end
  end


  def destroy
    @payment.destroy
    flash[:success] = "Zahlungsart #{@payment.name} gelöscht."
    redirect_to payments_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:name, :costs)
    end

end
