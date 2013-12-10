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
		$.post "/products/listOfProducts",
			data: cart
			dataType: 'json'
			@processData

	processData: (data, textStatus, jqXHR) ->
		$("#cart").html(data)
		# This class 'update_cart' exist avert html replace
		$(".btn_update").each (index) ->
			$( this ).click (event) ->
				alert("Update " +this.form.product_id.value)
		$(".btn_delete").each (index) ->
			$( this ).click (event) ->
				cartStorage = new CartStorage()
				cartStorage.deleteLineItem( this.form.product_id.value )
				if(cartStorage.isEmpty() )
					location.reload()
				else
					new CartMessage()



			
