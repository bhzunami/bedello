class PropertiesController < ApplicationController
	before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
  	@property = Property.new
  end

  def create
  	@property = Property.new(property_params)
  	if @property.save
  		redirect_to property_path(@property)
  	else
  		render action: 'new'
  	end
  end

  def edit
  end

  def update
  	@property = Property.find(params[:id])
    if @property.update_attributes(property_params)
      flash[:notice] = "Successfully updated property."
      redirect_to @property
    else
      render action: 'edit'
    end

  end

  def show
  end

  def destroy
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :description, propertyItems_attributes: [:id, :name, :description, :order, :_destroy])
    end
end
