require 'support/configuration'
require 'resources/hash'
require 'date'
require 'resources/checkout/billing/customer'
require 'resources/checkout/billing/payment'

module MusicTodayApiWrapper
  module Resources
    module Checkout
      class Order
        def initialize(customer, payment, destinations = [], items = [],
          promotions = [])
          config = MusicTodayApiWrapper::Configuration.new

          @catalog = config.catalog.to_i
          @channel = config.channel
          @prefix = config.order_prefix
          @customer = customer
          @payment = payment
          @destinations = destinations
          @items = items
          @promotions = promotions
        end

        # rubocop:disable MethodLength
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
                       payments: [@payment.as_hash] },
            currency: 'USD',
            destinations: @destinations.map(&:as_hash),
            lineItems: @items.map(&:as_hash),
            promotions: @promotions.map(&:as_hash) }.compact
        end
      end
    end
  end
end
