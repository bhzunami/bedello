module StaticPagesHelper

	def categories
		@categories = Category.all
	end
end
