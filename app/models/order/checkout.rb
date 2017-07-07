class Order
  module Checkout
    extend ActiveSupport::Concern

    included do
      state_machine :initial => :cart do
        before_transition :cart => :payment, :do => [:check_cart_state,:assign_default_payment]
        before_transition [:payment, :cart] => :completed, :do => [:check_payment_state, :finalize]
        event :comfirm do
          transition :cart => :payment
        end

        event :cancel do
          transition :payment => :canceled
        end

        event :complete do
          transition [:payment, :cart] => :completed
        end

        event :refund do
          transition :completed => :refunded
        end
      end
    end

    def next
      check_cart_state
      case state
      when 'cart'
        if payment_required?
          comfirm
        else
          complete
        end
      when 'payment'
        complete
      else
        fail Order::Error.new("订单已经完成，无法更改状态")
      end
    end

    private
    def check_cart_state
      fail Order::Error::Cart.new("购物车中没有任何商品") if item_count <= 0
      fail Order::Error::Address.new("缺少收货地址或信息不完整") if shipment_required? && !ship_address&.valid?
    end

    def assign_default_payment
      unless payment
        method = PaymentMethod.default
        fail Order::Error::Payment.new("没有可用的支付方式") unless method
        Payment.create(order: self, payment_method: method, amount: total)
      end
    end

    def check_payment_state
      if payment_require?
        fail Order::Error::Payment.new("未完成支付") unless payment.completed?
      end
    end

    def finalize
      completed_at = Time.now
    end
  end
end
