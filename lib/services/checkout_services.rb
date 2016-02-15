require 'rest_clients/music_today_rest_client'
require 'rest_clients/common_response'
require 'resources/purchase/item'
require 'resources/checkout/session'
require 'resources/checkout/order'
require 'resources/purchase/invoice'

module MusicTodayApiWrapper
  module Services
    class CheckoutServices
      def initialize
        @common_response = RestClients::CommonResponse.new
        @rest_client = RestClient.new
      end

      # rubocop:disable AbcSize
      def checkout(address, items)
        items_hash = items.map(&:as_hash)
        address_hash =
          address.as_hash.merge(id: 1, items: items_hash)

        @common_response.work do
          params = checkout_params(address_hash)
          response = @rest_client.checkout(params)

          session = response.data[:session]
          response_data = @common_response.data

          response_data[:session] =
            Resources::Checkout::Session.from_hash(session)
          response_data[:items] = session['items'].map do |item|
            Resources::Purchase::Item.from_hash(item)
          end
        end
      end

      def only_purchase(order)
        purchase do
          orders = [order.as_hash]
          @rest_client.purchase(orders: orders)
        end
      end

      def confirm_and_purchase(order)
        purchase do
          address_collection =
            Resources::Address.from_destinations(order.destinations)
          response = checkout(address_collection.first, order.items)
          order.items = response.data[:items]
          @rest_client.purchase(orders: [order.as_hash])
        end
      end

      private

      def purchase
        @common_response.work do
          response = yield
          if response.success?
            @common_response.data[:invoice] =
              Resources::Purchase::Invoice.from_hash(response.data[:order])
          else
            @common_response.errors = response.errors
            @common_response.data = {}
          end
        end
      end

      def checkout_params(address)
        { storeId: @rest_client.catalog_number,
          currency: 'USD',
          priceLevel: '',
          addresses: [address],
          promotions: [] }
      end
    end
  end
end
