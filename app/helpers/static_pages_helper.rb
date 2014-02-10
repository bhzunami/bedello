module StaticPagesHelper

	def categories
		Category.all( order: "category_order")
	end

	def isStoreOpen?
		@webstore =  WebsiteSettings.find(1)
		range = (@webstore.webstoreOpen..@webstore.webstoreClose)
		range.cover?(Time.now)
	end
end
