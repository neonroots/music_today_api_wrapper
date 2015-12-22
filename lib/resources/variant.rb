require 'resources/string'
module MusicTodayApiWrapper
  module Resources
    class Variant
      attr_accessor :sku,
                    :price,
                    :quantity_available,
                    :variant_names

      def initialize(sku, price, quantity_available, variant_names = [])
        @sku = sku
        @price = price
        @quantity_available = quantity_available
        @variant_names = variant_names
      end

      def self.from_hash(variant_hash)
        Variant.new(variant_hash['sku'],
                    variant_hash['listPrice'],
                    variant_hash['qtyAvailable'],
                    variant_names(variant_hash['variantNames']))
      end

      def self.variant_names(names)
        return [] unless names
        symbolized_names = []

        names.each do |variant|
          variant_name = {}
          variant_name[variant.keys[0]
            .to_underscore
            .to_sym] = variant.values[0]
          symbolized_names << variant_name
        end
        symbolized_names
      end
    end
  end
end
