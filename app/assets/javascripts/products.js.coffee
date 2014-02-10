# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org

@BEDELLO.products = 
	init: ->
		new InitalizeData()

	new: ->
		new InitalizeDatePicker()

	edit: ->
		new InitalizeDatePicker()

	index: ->
		$(".addToCart").each (index) ->
			$( this ).submit (event) -> # Fange Submit ab
				event.preventDefault()
				# Check Quantity
				inputQuantity = parseInt(this.quantity.value)
				# Get property id
				property_id = parseInt($(this).find(":selected").val())
				cartStorage = new CartStorage()
				cart = cartStorage.getObject()

				# Check if this product is in the cart
				if cart
					if cart.lineItems[this.id.value]?
						# get the product quantity of the cart
						oldQuantity = parseInt(cart.lineItems[this.id.value].quantity)

				# save a variable for post request checkQuantity
				quant = parseInt(this.quantity.value)
				# if we have a oldQuantity add it to quant
				if oldQuantity
					quant += oldQuantity
					# More than 10 are not allowed
					if quant > 10
						alert "Mehr als 10 Stk. sind nicht erlaubt!"
						return
					
				button = this
				product =
					id : this.id.value
					quantity : quant
					property : property_id

				$.ajax "/products/checkQuantity",
					type: 'POST'
					data: product
					dataType: 'json'
					success: (response) ->
						$(button).parent('.pull-right').find('.inStock').html("Verfügbar: " +response['inStock'])
						new ProductHandler(product.id, inputQuantity, $(button).parent('.pull-right').parent('.row').find("img").eq(0), property_id)

					error: ->
						inStock = $(button).parent('.pull-right').find('.inStock').text()
						oldQuntity = parseInt(inStock.substr(inStock.length-1) )
						if (oldQuntity - inputQuantity) < 0
							$(button).parent('.pull-right').find('.inStock').html("Verfügbar: 0")
						else 
							$(button).parent('.pull-right').find('.inStock').html("Verfügbar: " +(oldQuntity - inputQuantity))
						alert "Es hat nicht mehr soviele Produkte"

	show: ->
		$(".addToCart").each (index) ->
			$( this ).submit (event) -> # Fange Submit ab
				event.preventDefault()
				
				# Check Quantity
				inputQuantity = parseInt(this.quantity.value)
				property_id = parseInt($(this).find(":selected").val())
				cartStorage = new CartStorage()
				cart = cartStorage.getObject()

				# Check if this product is in the cart
				if cart
					if cart.lineItems[this.id.value]?
						# get the product quantity of the cart
						oldQuantity = parseInt(cart.lineItems[this.id.value].quantity)

				# save a variable for post request checkQuantity
				quant = parseInt(this.quantity.value)
				# if we have a oldQuantity add it to quant
				if oldQuantity
					quant += oldQuantity
					# More than 10 are not allowed
					if quant > 10
						alert "Mehr als 10 Stk. sind nicht erlaubt!"
						return
					
				button = this
				product =
					id : this.id.value
					quantity : quant
					property : property_id

				$.ajax "/products/checkQuantity",
					type: 'POST'
					data: product
					dataType: 'json'
					success: (response) ->
						$(".span3").find('.inStock').html("Verfügbar: " +response['inStock'])
						new ProductHandler(product.id, inputQuantity, $(".span3").find("img").eq(0), property_id)

					error: ->
						inStock = $(button).parent('.pull-right').find('.inStock').text()
						oldQuntity = parseInt(inStock.substr(inStock.length-1) )
						if (oldQuntity - inputQuantity) < 0
							$(button).parent('.pull-right').find('.inStock').html("Verfügbar: 0")
						else 
							$(button).parent('.pull-right').find('.inStock').html("Verfügbar: " +(oldQuntity - inputQuantity))
						alert "Es hat nicht mehr soviele Produkte"
					

class @ProductHandler
	constructor: (product, quantity, imageToDrag, property_id) ->
		cartStorage = new CartStorage()
		cartStorage.addLineItem(product, quantity, property_id)
		cart = $("#quantity_of_carts")
		if imageToDrag
			imgClone = imageToDrag.clone().offset(
				top: imageToDrag.offset().top
				left: imageToDrag.offset().left
			).css(
				opacity: "0.5"
				position: "absolute"
				"z-index": "100"
			).appendTo($("body")).animate(
				top: cart.offset().top + 40
				left: cart.offset().left + 50
				width: 75
				height: 75
				, 1000, "easeInOutExpo")
			imgClone.animate
				width: 0
				height: 0
			, ->
				$(this).detach()


class @InitalizeData
	constructor: ->
		@initalizeSideNav()
		#console.log("Called Product")
		# if cartStorage?
		# 	console.log("Leer")
		# else
		# 	console.log(this)

	initalizeSideNav: ->
		category = location.search.substring(1).split('=')
		$("#" + category[1]).addClass('active')

class @InitalizeDatePicker
	constructor: ->
		@setupDatePicker()

	setupDatePicker: ->
		console.log("FUCK YOU")
		alert("HALLO")
		$("#product_promotionStartDate").datepicker dateFormat: "dd/mm/yy"
		$("#product_promotionEndDate").datepicker dateFormat: "dd/mm/yy"
		$("#product_sale_start_date").datepicker dateFormat: "dd/mm/yy"
		$("#product_sale_end_date").datepicker dateFormat: "dd/mm/yy"
	
		$(".datepicker").each (i) ->
			unless $(this).val() is ''
				#console.log("Date" + $(this).val())
				date = new Date( $(this).val() )
				$(this).val $.datepicker.formatDate("dd/mm/yy", date)

