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

  edit: ->
    new InitalizeDatePickerOrders()

  update: ->
    new InitalizeDatePickerOrders()


class @InitalizeDatePickerOrders
  constructor: ->
    @setupDatePicker()

  formateDate:(date) ->
    date = new Date(date)
    return $.datepicker.formatDate("dd/mm/yy", date)

  setupDatePicker: ->
    $("#order_pay_day").datepicker dateFormat: "dd/mm/yy"
    $("#order_delivery_date").datepicker dateFormat: "dd/mm/yy"
    $("#order_warning").datepicker dateFormat: "dd/mm/yy"

    unless $("#order_pay_day").val() is ''
      $("#order_pay_day").val @formateDate($("#order_pay_day").val())
    unless $("#order_delivery_date").val() is ''
      $("#order_delivery_date").val @formateDate($("#order_delivery_date").val())
    unless $("#order_warning").val() is ''
      $("#order_warning").val @formateDate($("#order_warning").val())