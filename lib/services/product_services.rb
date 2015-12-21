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

      def find_product(id)
        results = @rest_client.find_product(id)
        return results unless results.success?

        @common_response.work do
          @common_response.data[:product] =
            MusicTodayApiWrapper::Resources::Product
            .from_hash(results.data[:product])
        end
      end

      private

      def product_mapper(product)
        product_obj =
          MusicTodayApiWrapper::Resources::Product.from_hash(product)
        @common_response.data[:products] << product_obj
      end
    end
  end
end
