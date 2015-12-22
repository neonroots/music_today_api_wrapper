require 'rest_clients/music_today_rest_client'
require 'rest_clients/common_response'
require 'resources/purchase/item'

module MusicTodayApiWrapper
  module Services
    class CheckoutServices
      def initialize
        @common_response = RestClients::CommonResponse.new
        @rest_client = RestClient.new
      end

      def checkout(address, items)
        items_hash = []
        items.each{ |item| items_hash << item.as_hash }
        address_hash =
          address
          .as_hash
          .merge(id: 1, items: items_hash)

        @common_response.work do
          params = { storeId: @rest_client.catalog_number, currency: 'USD',
            priceLevel: '', addresses:[address_hash], promotions: [] }
          response = @rest_client.checkout(params)

          return response unless response.success?
        end
      end
    end
  end
end
