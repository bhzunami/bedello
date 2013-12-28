class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy, :allProducts]

  # GET /products
  # GET /products.json
  def index
    # check if we get all products or only active
    if admin?
      @products = Product.where(category_id: params[:category_id] )
    else
      @products = Product.activeDate.where(category_id: params[:category_id])
      #@products = Product.activeDate
    end
  end

  def allProducts
    @products = Product.all( order: "title")
    render action: 'index'
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product #{@product.title} was successfully created." }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { 
          redirect_to @product
          flash[:success] = "Product #{@product.title} successfully updated" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { 
        redirect_to allProducts_path
        flash[:success] = "Product #{@product.title} successfully deleted" }
      format.json { head :no_content }
    end
  end

  def listOfProducts
    @cart = Array.new 
    lineItems = params[:data][:lineItems]
    lineItems.each do |key, li|
      product = Product.find( li[:product_id] )
      cart = {product: product, quantity: li[:quantity]}
      @cart.push(cart)
    end
    render layout: false
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
      #if @product.save
        format.json { render json: @product }
      #end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :productNr, :price, :promotionPrice, :promotionStartDate, :promotionEndDate, :image, :isActivate, :inStock, :sale_start_date, :sale_end_date, :category_id, :image)
    end

    def products_params
      param.require(:product)
    end
end
