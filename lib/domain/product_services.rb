require 'rest_clients/music_today_rest_client'
require 'resources/product'

module MusicTodayApiWrapper
  class ProductServices
    def initialize
      @common_response = CommonResponse.new
      @common_response.data[:products] = []
      @rest_client = MusicTodayApiWrapper::RestClient.new
    end

    def all_products
      results = @rest_client.all_products
      return results unless results.success?

      @common_response.work do
        results.data[:products].each { |product| product_mapper(product) }
      end
    end

    private

    def product_mapper(product)
      product_obj = Product.from_hash(product)
      @common_response.data[:products] << product_obj
    end
  end
end
