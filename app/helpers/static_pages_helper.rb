module StaticPagesHelper

	def categories
		Category.order(:category_order)
	end

	def isStoreOpen?
		@webstore =  WebsiteSettings.find(1)
		range = (@webstore.webstoreOpen..@webstore.webstoreClose)
		range.cover?(Time.now)
	end
end
