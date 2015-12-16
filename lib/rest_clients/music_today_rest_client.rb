require 'json'
require 'net/http'
require 'rest_clients/common_response'
require 'support/configuration'

module MusicTodayApiWrapper
  class RestClient
    def initialize
      config = MusicTodayApiWrapper::Configuration.new
      @url = config.url
      @user = config.user
      @api_key = config.api_key
      @catalog_number = config.catalog
      @common_response = MusicTodayApiWrapper::RestClients::CommonResponse.new
    end

    def all_products
      @common_response.work do
        uri =
          URI("#{@url}/catalog/content/#{@catalog_number}/?apiuser=#{@user}&"\
          "apikey=#{@api_key}")
        res = Net::HTTP.get_response(uri)
        @common_response.data[:products] = JSON.parse(res.body)['products']
      end
    end

    def find_product(product_id)
      @common_response.work do
        uri =
          URI("#{@url}/catalog/product/#{@catalog_number}/#{product_id}?"\
          "apiuser=#{@user}&apikey=#{@api_key}")
        res = Net::HTTP.get_response(uri)
        @common_response.data[:product] = JSON.parse(res.body)['product']
      end
    end
  end
end
