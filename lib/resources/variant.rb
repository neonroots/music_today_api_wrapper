module MusicTodayApiWrapper
  module Resources
    class Variant
      attr_accessor :sku,
                    :price,
                    :quantity_available,
                    :size,
                    :format,
                    :bitrate

      # rubocop:disable ParameterLists
      def initialize(sku, price, quantity_available, size = nil, format = nil,
        bitrate = nil)
        @sku = sku
        @price = price
        @quantity_available = quantity_available
        @size = size
        @format = format
        @bitrate = bitrate
      end

      def self.from_hash(variant_hash)
        size, format, bitrate = nil

        variant_hash['variantNames'].each do |name|
          variant_size = name['Size']
          variant_format = name['Format']
          variant_bitrate = name['Bitrate']

          size = variant_size if variant_size
          format = variant_format if variant_format
          bitrate = variant_bitrate if variant_bitrate
        end

        Variant.new(variant_hash['sku'],
                    variant_hash['listPrice'],
                    variant_hash['qtyAvailable'],
                    size,
                    format,
                    bitrate)
      end
    end
  end
end
