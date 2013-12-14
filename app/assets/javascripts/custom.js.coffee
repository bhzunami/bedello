# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class @CUSTOM_LOADER
	constructor: ->
		body = document.body
		controller = body.getAttribute 'data-controller'
		action = body.getAttribute 'data-action' 

		@exec 'common'
		@exec controller
		@exec controller, action

	exec: (controller, action) ->
		action = 'init' unless action?
		BEDELLO[controller]?[action]?()


# Turbo Links need this!!!!
$(document).on "ready page:load", ->
	new CUSTOM_LOADER()
	
