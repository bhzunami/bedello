class CustomersController < ApplicationController

  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def new
    @customer = Customer.new
  end


  def create
    @customer = Customer.new(customer_params)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:formOfAddress, :firstname, :lastname, :streetname, :addressAdditive, :plz, :city, :email, :phone)
    end
end
