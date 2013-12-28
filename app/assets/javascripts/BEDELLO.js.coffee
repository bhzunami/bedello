class @BEDELLO

# common functions
@BEDELLO.common =
	init: ->
		new MenubarController()
		cartStorage = new CartStorage()
		cartStorage.updateCartSum(cartStorage.getQuantityOfLineItem())
		
		# visit page with javascript
		window.visit = (url) ->
			window.location = './' + url if url?

