# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@BEDELLO.carts = 
	init: ->

	show: ->
		new UpdateQuantity()

class @UpdateQuantity
	constructor: ->
		@updateQuant()

	updateQuant: ->	
		#console.log("Update")
		#$("#quantity").change ->
  	#	$(this).closest("form").submit()
