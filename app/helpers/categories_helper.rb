module CategoriesHelper

# Get the highest category order
  def get_highest_index_of_category
    category = Category.all( order: "category_order")
    max = 0;
    category.each do |c|
      if c.category_order > max
        max = c.category_order
      end
    end
    max + 1
  end
end
