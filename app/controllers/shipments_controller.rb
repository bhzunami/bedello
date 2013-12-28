class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @shipments = Shipment.all   
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      flash[:success] = "Shipment #{@shipment.name} saved successfully"
      redirect_to @shipment
    else
      render action: 'new'
    end
  end


  def new
    @shipment = Shipment.new
  end

  # GET /shipment/1/edit
  def edit
  end

  def update
    if @shipment.update(shipment_params)
      flash[:success] = "Shipment #{@shipment.name} updated successfully"
      redirect_to shipments_path
    else
      render action: 'edit'
    end
  end


  def destroy
    @shipment.destroy
    flash[:success] = "Shipment #{@shipment.name} succesfull deleted"
    redirect_to shipments_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipment_params
      params.require(:shipment).permit(:name, :costs)
    end

end
