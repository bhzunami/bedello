# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org

jQuery ($) ->
	$(".bs-docs-sidenav li a").click (e) ->
		$(".bs-docs-sidenav li").removeClass "active"
		$this = $(this)
		$this.addClass "active"  unless $this.hasClass("active")
		e.preventDefault()
		