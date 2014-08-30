class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy, :indexAllProducts]

  def index
    # check if we get all products or only active
    if admin?
      @products = Product.where(category_id: params[:category_id] )
    else
      @products = Product.active.where(category_id: params[:category_id] ).order("product_nr") #Product.activeDate.where(category_id: params[:category_id])

      #@products = Product.activeDate
    end
    @category = Category.find(params[:category_id])
    
  end

  # List all products
  def indexAllProducts
    @products = Product.all( order: "product_nr")
    render action: 'index'
  end

  def show
    @properties = @product.property.propertyItems unless @product.property.nil?
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Product #{@product.title} was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @product.update(product_params)
        redirect_to @product
        flash[:success] = "Product #{@product.title} successfully updated"
    else
      render action: 'edit'
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if @product.destroy
      redirect_to indexAllProducts_path
      flash[:success] = "Product #{@product.title} successfully deleted"
    end
  end

  def checkQuantity
    quantity = params[:quantity]
    @product = Product.find(params[:id])
    if !@product
      render(file: File.join(Rails.root, 'public/500.html'), status: 500, layout: false)
      return
    end
    if @product.inStock - quantity.to_f < 0
      render(file: File.join(Rails.root, 'public/500.html'), status: 500, layout: false)
      return
    end

    @product.inStock -= quantity.to_f
    respond_to do |format|
      format.json { render json: @product }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :product_nr, :price, :promotionPrice, :promotionStartDate, :promotionEndDate, :image, :isActivate, :inStock, :sale_start_date, :sale_end_date, :category_id, :image, :property_id)
    end

end
