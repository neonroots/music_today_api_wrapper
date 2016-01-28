require 'support/configuration'
require 'resources/hash'
require 'date'
require 'resources/checkout/billing/customer'
require 'resources/checkout/billing/payment'

module MusicTodayApiWrapper
  module Resources
    module Checkout
      class Order
        def initialize(customer =
          MusicTodayApiWrapper::Resources::Checkout::Billing::Customer.new,
          payment =
          MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new)
          config = MusicTodayApiWrapper::Configuration.new

          @catalog = config.catalog.to_i
          @channel = config.channel
          @prefix = config.order_prefix
          @customer = customer
          @payment = payment
        end

        def as_hash
          dynamic_id = @prefix + Time.now.to_i.to_s

          { storeId: @catalog,
            channel: @channel,
            orderDate: DateTime.now.to_s,
            clientOrderId: dynamic_id,
            clientCustomerId: dynamic_id,
            sendConfEmail: true,
            sendDigitalConfEmail: true,
            applyFraudCheck: true,
            validateOnly: false,
            taxPrepaid: false,
            billing: { customer: @customer.as_hash,
                       payment: @payment.as_hash },
            currency: 'USD' }.compact
        end
      end
    end
  end
end
