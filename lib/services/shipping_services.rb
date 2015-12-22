require 'rest_clients/music_today_rest_client'
require 'resources/purchase/shipping_option'

module MusicTodayApiWrapper
  module Services
    class ShippingServices
      def initialize
        @common_response = RestClients::CommonResponse.new
        @common_response.data[:shipping_options] = []
        @rest_client = RestClient.new
      end

      def options(address, items)
        hash_items = []
        items.each { |item| hash_items << item.as_hash }

        params = { storeId: @rest_client.catalog_number,
                   address: address.as_hash,
                   lineItems: hash_items }
        @common_response.work do
          response = @rest_client.shipping_options(params)
          return response unless response.success?

          response
            .data[:shipping_options]
            .each { |option| shipping_option_mapper(option) }
        end
      end

      private

      def shipping_option_mapper(option)
        @common_response.data[:shipping_options] <<
          Resources::Purchase::ShippingOption.from_hash(option)
      end
    end
  end
end
