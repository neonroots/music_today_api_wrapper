require 'resources/hash'
require 'resources/address'

module MusicTodayApiWrapper
  module Resources
    module Checkout
      class Destination
        attr_accessor :address, :shipping_option, :shipping_cost

        def initialize(address, shipping_option = '', shipping_cost = 0.0)
          @address = address
          @shipping_option = shipping_option
          @shipping_cost = shipping_cost.to_f
        end

        def as_hash
          { requestedShippingOption: @shipping_option,
            shippingCost: @shipping_cost,
            shipToBillTo: false,
            address: @address.as_hash }
        end
      end
    end
  end
end
