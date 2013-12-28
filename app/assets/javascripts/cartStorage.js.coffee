class @CartStorage
  constructor: ->

  setObject: (value)->
    localStorage.setItem "cart", JSON.stringify(value)

  getObject: ->
    if !localStorage.getItem("cart")?
      return null
    JSON.parse localStorage.getItem("cart")

  deleteOpbject: ->
    console.log("Remoe Local Storage")
    localStorage.clear()

  addLineItem: (productId, quan) ->
    productId = parseInt(productId)
    quan = parseInt(quan)
    if !@getObject()?
      lineItems = {}
      lineItems[productId] =
        product_id : productId
        quantity : quan
      cart = 
        lineItems : lineItems
        length : 1
    else
      cart = @getObject()
      if cart.lineItems[productId]?
        cart.lineItems[productId].quantity += quan
      else
        cart.lineItems[productId] =
          product_id : productId
          quantity : quan
        cart.length += 1

    @setObject(cart)
    @updateCartSum(@getQuantityOfLineItem())

  getQuantityOfLineItem: ->
    cart = @getObject()
    sum = 0
    if !cart?
      return 0
    for count of cart.lineItems
      lineItem = cart.lineItems[count]
      sum += lineItem.quantity
    return sum

  updateCartSum: (sum) ->
    if sum > 0
      $("#quantity_of_carts a").first().text("Warenkorb ("+sum+")")
    if sum == 0
      $("#quantity_of_carts a").first().text("Warenkorb")

  deleteLineItem: (productId) ->
    cart = @getObject()
    delete cart.lineItems[productId]
    cart.length -= 1
    @setObject(cart)
    @updateCartSum(@getQuantityOfLineItem())


  updateLineItem: (productId, quantity) ->
    cart = @getObject()
    quan = parseInt(quantity)
    cart.lineItems[productId].quantity = quan
    @setObject(cart)
    @updateCartSum(@getQuantityOfLineItem())

  isEmpty: ->
    cart =  @getObject()
    if cart?
      if cart.length == 0
        true 
      else
        false
    else
      true