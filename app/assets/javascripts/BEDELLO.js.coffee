class @BEDELLO

# common functions
@BEDELLO.common =
	init: ->
		new MenubarController()
		#cartStorage = new CartStorage()
		console.log("init of common")
		cartStorage.updateCartSum(cartStorage.getQuantityOfLineItem())
		
		# visit page with javascript
		window.visit = (url) ->
			window.location = './' + url if url?

class @CartStorage
	constructor: ->

	setObject: (value)->
		localStorage.setItem "cart", JSON.stringify(value)

	getObject: ->
		if !localStorage.getItem("cart")?
			return null
		JSON.parse localStorage.getItem("cart")

	deleteOpbject: ->
		localStorage.clear()

	addLineItem: (productId, quan) ->
		productId = parseInt(productId)
		quan = parseInt(quan)
		if !@getObject()?
			lineItems = {}
			lineItems[productId] =
				product_id : productId
				quantity : quan
			cart = 
				lineItems : lineItems
		else
			cart = @getObject()
			if cart.lineItems[productId]?
				cart.lineItems[productId].quantity += quan
			else
				cart.lineItems[productId] =
					product_id : productId
					quantity : quan				

		@setObject(cart)
		@updateCartSum(@getQuantityOfLineItem())

	getQuantityOfLineItem: ->
		cart = @getObject()
		sum = 0
		if !cart?
			return 0
		for count of cart.lineItems
			lineItem = cart.lineItems[count]
			sum += lineItem.quantity
		return sum

	updateCartSum: (sum) ->
		console.log("Update: " +sum)
		if sum > 0
			$("#quantity_of_carts a").first().text("Warenkorb ("+sum+")")

	deleteLineItem: (productId, cart) ->
		#cart = @getObject()
		delete cart.lineItems[productId]
		@isEmpty(cart)
		@setObject(cart)
		@updateCartSum(@getQuantityOfLineItem())

	isEmpty: (cart) ->
		if cart?
			console.log("cart is not empty")
			if cart.lineItems?
				console.log("lineItems is not empty")
				true
			else
			console.log("lineItems is empty")
			@deleteOpbject()
			false
		else
			console.log("cart is empty")
			false

cartStorage = new CartStorage()
console.log("I'm OUT")