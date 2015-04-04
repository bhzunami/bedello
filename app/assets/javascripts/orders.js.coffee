# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@BEDELLO.orders = 

  init: ->
    DEFAULT_SHIPMENT_COSTS = 16.00
    recal = false

  new: ->
    cartStorage = new CartStorage()
    $.post "/orders/createNewOrder",
      data: cartStorage.getObject()
      dataType: 'json'
      (data) -> 
        $("#order").html(data)

  create: ->
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

  edit: ->
    new InitalizeDatePickerOrders()


class @InitalizeDatePickerOrders
  constructor: ->
    @setupDatePickerOrders()

  formateDate:(date) ->
    date = new Date(date.split(" ")[0])
    return $.datepicker.formatDate("dd/mm/yy", date)

  setupDatePickerOrders: ->
    $("#order_pay_day").datepicker dateFormat: "dd/mm/yy"
    $("#order_delivery_date").datepicker dateFormat: "dd/mm/yy"

    unless $("#order_pay_day").val() is ''
      $("#order_pay_day").val @formateDate($("#order_pay_day").val())
    unless $("#order_delivery_date").val() is ''
      $("#order_delivery_date").val @formateDate($("#order_delivery_date").val())

# paymentChange = ->
# # TODO:
# # Nachnahme should also do a recalculation
#   selected = $("#drop_pay :selected").text()
#   if selected is "Bar (Ware wird abgeholt)"
#     $("#drop_ship").val 1
#     $("#drop_ship option:selected").attr "disabled", "disabled"
#     $("#drop_ship").val 2
#     # remove Lieferkosten when exist
#     $("#shipment").hide()
#     $("#total_price").find("strong").replaceWith reCalculateTotalCosts($("#total_price").find("strong").html(), true, DEFAULT_SHIPMENT_COSTS)
#   else
#     $("#drop_ship").val 2
#     $("#drop_ship option:selected").attr "disabled", "disabled"
#     $("#drop_ship").val 1
#     $("#shipment").show()
#     $("#total_price").find("strong").replaceWith reCalculateTotalCosts($("#total_price").find("strong").html(), false, DEFAULT_SHIPMENT_COSTS)
#   return

# reCalculateTotalCosts = (actualCost, minus, amount) ->
#   price = Number(actualCost.replace(/[^0-9\.]+/g, ""))
#   return printPrice(price)  if recal is false and minus is false
#   if minus
#     price -= amount
#     recal = true
#   else
#     price += amount
#     recal = false
#   printPrice price

# printPrice = (price) ->
#   price = $.number(price, 2, ".")
#   "<strong> CHF " + price + "</strong>"
