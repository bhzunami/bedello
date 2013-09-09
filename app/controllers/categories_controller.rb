class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]

  
  def index
  	@categories = Category.all
  end

  def new
  	@category = Category.new
  end

  def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "Category saved successfully"
			redirect_to categories_path
		else 
			render action: 'new'
		end
  end

  def edit
  end

  def update
  	if @category.update(category_params)
  		flash[:success] = "Category updated successfully"
			redirect_to categories_path
		else
			render action: 'edit'
		end
  end

  def show
  end

  def destroy
  	@category.destroy
  	flash[:success] = "Category #{@category.name} succesfull deleted"
 		redirect_to categories_url
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description)
    end
end
