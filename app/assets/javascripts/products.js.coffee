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
				cartStorage = new CartStorage()
				cartStorage.addLineItem(this.id.value, this.quantity.value)
				event.preventDefault() # Damit es nicht weiter an den Server gesendet wird

				cart = $("#quantity_of_carts")
				imageToDrag = $(this).parent('.pull-right').parent('.row').find("img").eq(0)
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


	show: ->
		$(".addToCart").each (index) ->
			$( this ).submit (event) -> # Fange Submit ab
				cartStorage = new CartStorage()
				cartStorage.addLineItem(this.id.value, this.quantity.value)
				event.preventDefault() # Damit es nicht weiter an den Server gesendet wird

				cart = $("#quantity_of_carts")
				#imageToDrag = $(this).parent('.pull-right').parent('.addToCart').parent('.span7').parent('.row').find("img").eq(0)
				imageToDrag = $(".span3").find("img").eq(0)
				console.log(imageToDrag)
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
		$("#product_promotionStartDate").datepicker dateFormat: "dd/mm/yy"
		$("#product_promotionEndDate").datepicker dateFormat: "dd/mm/yy"
		$("#product_sale_start_date").datepicker dateFormat: "dd/mm/yy"
		$("#product_sale_end_date").datepicker dateFormat: "dd/mm/yy"
	
		$(".datepicker").each (i) ->
			unless $(this).val() is ''
				#console.log("Date" + $(this).val())
				date = new Date( $(this).val() )
				$(this).val $.datepicker.formatDate("dd/mm/yy", date)

