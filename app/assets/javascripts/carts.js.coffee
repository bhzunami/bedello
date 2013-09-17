# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@BEDELLO.carts = 
	init: ->

	edit: ->
		new UpdateQuantity()

	update: ->
		new UpdateQuantity()


class @UpdateQuantity
	constructor: ->
		@updateQuant()

	updateQuant: ->	
		consle.log("Update")
		$("#quantity").change ->
  		alert "Handler for .change() called."
