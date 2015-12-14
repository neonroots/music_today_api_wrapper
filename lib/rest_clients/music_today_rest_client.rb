require 'json'
require 'net/http'
require './lib/rest_clients/common_response'
require './lib/support/configuration'

module MusicTodayApiWrapper
  class RestClient
    def initialize
      config = MusicTodayApiWrapper::Configuration.new
      @url = config.url
      @user = config.user
      @api_key = config.api_key
      @common_response = CommonResponse.new
    end

    def all_products
      @common_response.work do
        uri =
          URI("#{@url}/catalog/content/1/?apiuser=#{@user}&apikey=#{@api_key}")
        res = Net::HTTP.get_response(uri)
        @common_response.data[:products] = JSON.parse(res.body)['products']
      end
    end
  end
end
