class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  before_action :admin_user

  def index
    @shipments = Shipment.order(:name)   
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      flash[:success] = "Lieferart #{@shipment.name} gespeichert."
      redirect_to shipments_path
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
      flash[:success] = "Lieferart #{@shipment.name} aktualisiert."
      redirect_to shipments_path
    else
      render action: 'edit'
    end
  end


  def destroy
    @shipment.destroy
    flash[:success] = "Lieferart #{@shipment.name} gelöscht."
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
