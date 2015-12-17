require 'rest_clients/music_today_rest_client'
require 'resources/product'

module MusicTodayApiWrapper
  module Services
    class ProductServices
      def initialize
        @common_response =
          MusicTodayApiWrapper::RestClients::CommonResponse.new
        @rest_client = MusicTodayApiWrapper::RestClient.new
      end

      def all_products
        results = @rest_client.all_products
        return results unless results.success?

        @common_response.data[:products] = []
        @common_response.work do
          results.data[:products].each { |product| product_mapper(product) }
        end
      end

      def find_product(parent_id, id)
        results = @rest_client.find_product(parent_id)
        return results unless results.success?

        @common_response.work do
          find_variant(id, results.data[:product])
        end
      end

      private

      def product_mapper(product)
        @common_response.data[:products] +=
          Resources::Product.from_hash(product)
      end

      def find_variant(id, product_and_variants)
        products = Resources::Product.from_hash(product_and_variants)
        @common_response.data[:product] =
          products.find { |product| product.uid == id }
      end
    end
  end
end
