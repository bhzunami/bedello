# menubar

class @MenubarController
	constructor: ->
		activePage = @stripTrailingSlash window.location.pathname
		$('.nav li a').each (i, el) =>
			currentPage = @stripTrailingSlash $(el).attr('href')
			$(el).parent().addClass 'active' if activePage == currentPage

	stripTrailingSlash: (str) ->
		return str.substr(0, str.length - 1) if str.substr(-1) == '/'
		str