require 'resources/variant'
module MusicTodayApiWrapper
  module Resources
    module Purchase
      class Item
        attr_accessor :variant, :quantity

        def initialize(variant = Variant.new, quantity = 1)
          @variant = variant
          @quantity = quantity
        end

        def as_hash
          { sku: @variant.sku,
            qty: @quantity,
            price: @variant.price }
        end
      end
    end
  end
end
