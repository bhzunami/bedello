module OrdersHelper

  def getPrice(lineItem)
    if not lineItem
      return
    end
    if (lineItem.product.promotionStartDate..lineItem.product.promotionEndDate).cover?(Time.now)
      lineItem.quantity * lineItem.product.promotionPrice
    else 
      lineItem.quantity * lineItem.product.price
    end
  end

  def getTotPrice(lineItems)
    total_price = lineItems.to_a.sum { |l| getPrice(l) }
    if total_price < 200
      total_price += 16
    end
    total_price
  end

  def getShipPrice(order)
    total_price = order.line_items.to_a.sum { |l| getPrice(l) }
    if total_price < 200
      total_price += 16
    end
    total_price + order.shipment.costs + order.payment.costs
  end

  def isFlatrate?(order)
    total_price = order.line_items.to_a.sum { |l| getPrice(l) }
    if total_price < 200
      return true
    else
      return false
    end
  end

end
