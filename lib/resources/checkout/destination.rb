require 'resources/hash'
require 'resources/address'

module MusicTodayApiWrapper
  module Resources
    module Checkout
      class Destination
        attr_accessor :customer, :shipping_option, :shipping_cost

        def initialize(customer, shipping_option = '', shipping_cost = 0.0)
          @customer = customer
          @shipping_option = shipping_option
          @shipping_cost = shipping_cost.to_f
        end

        def as_hash
          { requestedShippingOption: @shipping_option,
            shippingCost: @shipping_cost,
            shipToBillTo: false,
            address: @customer.as_hash }
        end
      end
    end
  end
end
