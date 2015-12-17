require 'resources/product'
module MusicTodayApiWrapper
  module Resources
    module Purchase
      class Item
        attr_accessor :product, :quantity

        def initialize(product = Product.new, quantity = 1)
          @product = product
          @quantity = quantity
        end

        def as_hash
          { sku: @product.uid,
            qty: @quantity,
            price: @product.price }
        end
      end
    end
  end
end
