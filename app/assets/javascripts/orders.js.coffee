# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@BEDELLO.orders = 
  init: ->

  new: ->
    cartStorage = new CartStorage()
    $.post "/orders/createNewOrder",
      data: cartStorage.getObject()
      dataType: 'json'
      (data) -> 
        $("#order").html(data)

  show: ->
    cartStorage = new CartStorage()
    cartStorage.deleteOpbject()
    cartStorage.updateCartSum(0)