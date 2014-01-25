class LineItemsController < ApplicationController
  def new
    @lineItem = LineItem.new
  end

  def create
    @lineItem = LineItem.new(lineItems_params)
  end

    private
  # Never trust parameters from the scary internet, only allow the white list through.
    def lineItems_params
      params.require(:lineItem).permit(:product_id, :quantity, :propertyItem_id, product_params: [:title, :description, :productNr, :price, :promotionPrice, :promotionStartDate, :promotionEndDate, :image, :isActivate, :inStock, :sale_start_date, :sale_end_date, :category_id, :image, :property_id])
    end
end
