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
		cartStorage = new CartStorage()
		$(".addToCart").each (index) ->
			$( this ).submit (event) -> # Fange Submit ab
				cartStorage.addLineItem(this.id.value, this.quantity.value)
				event.preventDefault() # Damit es nicht weiter an den Server gesendet wird



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

