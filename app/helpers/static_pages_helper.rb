module StaticPagesHelper

	def categories
		Category.all( order: "category_order")
	end
end
