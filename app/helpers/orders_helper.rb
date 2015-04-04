module OrdersHelper

  # A property of a color for a product.
  # Get the name of the property
  def property(lineItem)
    lineItem.propertyItem.name unless lineItem.propertyItem.nil?
  end


  def get_status(order)
    #---------------------------
    # Bar
    #---------------------------
    if order.payment.short_name == "Bar"
      if order.delivery_date? && order.pay_day?
        order.status = "ok"
        return "Abgeschlossen"
      else
        order.status = "warn"
        return "bereitstellen"
      end
    #---------------------------
    # Rechnung Nachname
    #---------------------------
    elsif order.payment.short_name == 'Rechnung' or order.payment.short_name == 'Nachnahme'
      # Rechnung bei neuer bestellung orange, solange nicht mehr als 23 Tage alt
      # Rot: wenn mehr als 23 Tage alt
      # Grün: wenn es ein versanddatum mit nummer hat
      # Check if order is complete
      if order.delivery_date? && order.pay_day?
        order.status = "ok"
        return "Abgeschlossen"
      end
      # Überprüfen wenn ware versendet wurde ob Rechnung gezahlt wurde
      if order.delivery_date? && order.pay_day.nil?
        if order.delivery_date > (Time.now-30.days)
          order.status = "warn"
          return "Warten auf Zahlung"
        else
          order.status = "error"
          return "Mahnung senden!"
        end
      end
      # Überprüfen ob ware schon versendet wurde
      # Ersten zwei Tage ist es noch grün. Ab dem Dritten Tag wird es orange
      if order.created_at > 3.day.ago#(Time.now-3.days)
        order.status = "ok"
        return "Ware versenden"
      # Ab dem 3 bis zum 5 Tag ist es Orange
      elsif order.created_at > 6.day.ago
        order.status = "warn"
        return "Ware versenden"
      # Ab dem 6 Tag ist es rot
      else
        order.status = "error"
        return "Ware sofort versenden"
      end
    #---------------------------
    # Vorauszahlung
    #---------------------------
    elsif order.payment.short_name == 'Vorauszahlung'
      # *** Bezahlt und gelifert
      if order.delivery_date? && order.pay_day?
        order.status = "ok"
        return "Abgeschlossen"
      end
      # *** Wenn noch nicht bezahlt
      # Wenn Bestellung über ein Monat alt ist und keine Zahlung eingegangen ist
      if order.pay_day.nil? and order.created_at < 1.month.ago
        order.status = "warn"
        return "Bestellung aktuell"
      end
       # Ansonsten ist die Bestellung ok. wir warten auf Zahlungseingang
      if order.pay_day.nil?
        order.status = "ok"
        return "Warten auf Zahlung"
      end
      # *** Wenn Bezahlt wurde aber noch keine Ware versendet wurde
      # 2 Tage nach Zahlungseingang ist noch ok
      if order.pay_day > 3.day.ago
        order.status = "ok"
        return "Ware versenden"
      # Ab dem 3. Tag ist es orange
      elsif order.pay_day > 6.day.ago
        order.status = "warn"
        return "Ware versenden"
      else
        # Über 6 Tage ist Rot
        order.status = "error"
        return "Ware sofort versenden"
      end

    end
  end


end
