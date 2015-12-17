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
        url = "#{@url}/catalog/content/#{@catalog_number}/"

        @common_response.data[:products] = get(url)['products']
      end
    end

    def find_product(product_id)
      @common_response.work do
        url = "#{@url}/catalog/product/#{@catalog_number}/#{product_id}"

        @common_response.data[:product] = get(url)['product']
      end
    end

    private

    def get(url, options = {})
      options.merge!(apiuser: @user, apikey: @api_key)

      uri = URI(url)
      uri.query = URI.encode_www_form(options)

      response = Net::HTTP.get_response(uri)

      JSON.parse(response.body)
    end
  end
end
