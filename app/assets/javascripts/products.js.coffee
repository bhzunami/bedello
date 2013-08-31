# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org

@BEDELLO.products = 
	init: ->
		new InitalizeData()

	new: ->
		new InitalizeData()

	edit: ->
		new InitalizeData()


class @InitalizeData
	constructor: ->
		@initalizeDatePicker()
		@initalizeSideNav()

	initalizeDatePicker: ->
		$("#product_promotionStartDate").datepicker dateFormat: "dd.mm.yy"
		$("#product_promotionEndDate").datepicker dateFormat: "dd.mm.yy"
		$("#product_saleStartDate").datepicker dateFormat: "dd.mm.yy"
		$("#product_salesEndDate").datepicker dateFormat: "dd.mm.yy"
	
		$(".datepicker").each (i) ->
			unless $(this).val() is ''
				date = new Date( $(this).val() )
				$(this).val $.datepicker.formatDate("dd.mm.yy", date)

	initalizeSideNav: ->
		category = location.search.substring(1).split('=')
		$("#" + category[1]).addClass('active')