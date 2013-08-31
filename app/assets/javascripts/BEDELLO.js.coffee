class @BEDELLO

# common functions
@BEDELLO.common =
	init: ->
		new MenubarController()
		
		# visit page with javascript
		window.visit = (url) ->
			window.location = './' + url if url?
		


