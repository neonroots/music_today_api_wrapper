require 'resources/variant'
require 'resources/hash'

module MusicTodayApiWrapper
  module Resources
    module Purchase
      class Item
        attr_accessor :variant, :quantity

        def initialize(variant = Variant.new, quantity = 1, tax = nil,
          total = nil)
          @variant = variant
          @quantity = quantity
          @tax = tax
          @total = total
        end

        def as_hash
          { sku: @variant.sku,
            qty: @quantity,
            quantity: @quantity,
            price: @variant.price,
            tax: @tax,
            total: @total }.compact
        end

        def self.from_hash(item_hash)
          variant = Variant.from_hash(item_hash)
          Item.new(variant, item_hash['quantity'], item_hash['tax'],
            item_hash['total'])
        end
      end
    end
  end
end
