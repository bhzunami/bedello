# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@BEDELLO.carts = 
	init: ->

	index: ->
		new CartMessage()
		
class @CartMessage
	constructor: ->
		cartStorage = new CartStorage()
		cart = cartStorage.getObject()
		if cartStorage.isEmpty()
			return
		# Add spinner
		opts = {
			lines: 13
			length: 15
			width: 8
			radius: 58
			corners: 1
			rotate: 48
			direction: 1
			color: '#000'
			speed: 1
			trail: 65
			shadow: false
			hwaccel: false
			className: 'spinner'
			zIndex: 2e9
			top: 'auto'
			left: 'auto'
		};
		target = document.getElementById("spinner")
		spinner = new Spinner(opts).spin(target)

		$.post "/products/listOfProducts",
			data: cart
			dataType: 'json'
			@processData

	processData: (data, textStatus, jqXHR) ->
		$("#cart").html(data)
		
		cartStorage = new CartStorage()
		# This class 'update_cart' exist avert html replace
		$(".btn_update").each (index) ->
			$( this ).click (event) ->
				cartStorage.updateLineItem(this.form.product_id.value, this.form.quantity.value)
				location.reload()
				$(".alert").alert()
		$(".btn_delete").each (index) ->
			$( this ).click (event) ->
				cartStorage.deleteLineItem( this.form.product_id.value )
				if(cartStorage.isEmpty() )
					location.reload()
				else
					new CartMessage()



			
