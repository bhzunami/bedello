class OrderNotifierMailer < ActionMailer::Base
  include OrdersHelper
  include ProductsHelper
  helper :orders
  helper :products
  default from: "no-replay@bedello.ch"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier_mailer.notifier.subject
  #

# Send to customer
 def order_confirmation(order)
    @order = order
    mail to: order.customer.email, subject: "Bestellbestätiung Bedello"
  end

# Send to bedello
  def order_notification(order)
    @order = order
    mail to: "j.bechtel@vtxmail.ch", subject: "Neue Bestellung"
  end
end

