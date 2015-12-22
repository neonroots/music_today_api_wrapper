require 'resources/hash'

module MusicTodayApiWrapper
  module Resources
    module Purchase
      class ShippingOption
        attr_accessor :type, :delivery_date, :rate, :description

        def initialize(type, delivery_date = nil, rate = nil,
          description = nil)
          @type = type
          @delivery_date = delivery_date ? Date.parse(delivery_date) : nil
          @rate = rate
          @description = description
        end

        def self.from_hash(option)
          ShippingOption.new(option['shippingOptionType'],
                             option['deliveryDate'],
                             option['totalRate'],
                             option['shippingOptionName'])
        end

        def as_hash
          { shippingOptionType: @type, deliveryDate: @delivery_date,
            totalRate: @rate, shippingOptionName: @description }.compact
        end
      end
    end
  end
end
