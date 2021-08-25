class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[pay_with_paypal process_paypal_payment ]


  def show
    @order = current_order
  end

  def pay_with_paypal
    response = EXPRESS_GATEWAY.setup_purchase(@order.total_in_cents,
      ip: request.remote_ip,
      return_url: process_paypal_payment_cart_url,
      cancel_return_url: root_url,
      allow_guest_checkout: true,
      currency: 'USD'
    )
    token = response.token
    Payment.start_payment_process(@order, token)
    redirect_to EXPRESS_GATEWAY.redirect_url_for(token)
  end

  def process_paypal_payment
    @details = EXPRESS_GATEWAY.details_for(params_token)
    response = EXPRESS_GATEWAY.purchase(order_USD, express_purchase_options)
    if response.success?
      payment = Payment.find_by(token: response.token)
      payment.complete_payment
      UserNotifierMailer.purchase_confirmation_mail(current_user, @order).deliver_now
      redirect_to root_path, notice: 'Successful purchase! Thank you!'
    else
      redirect_to root_path, alert: "We're having some troubles processing your payment, please try again!"
    end
  end

  private

  def set_order
    @order = Order.find(params[:cart][:order_id])
  end

  def params_token
    params[:token]
  end

  def order_USD
    @details.params['order_total'].to_d / 750 * 100
  end

  def express_purchase_options
    {
      ip: request.remote_ip,
      token: params_token,
      payer_id: @details.payer_id,
      currency: 'USD'
    }
  end
end
