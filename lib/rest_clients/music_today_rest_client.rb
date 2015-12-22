require 'json'
require 'net/http'
require 'rest_clients/common_response'
require 'support/configuration'

module MusicTodayApiWrapper
  class RestClient
    attr_accessor :catalog_number

    def initialize
      config = MusicTodayApiWrapper::Configuration.new
      @url = config.url
      @user = config.user
      @api_key = config.api_key
      @catalog_number = config.catalog.to_i
      @common_response = MusicTodayApiWrapper::RestClients::CommonResponse.new
    end

    def all_products(per_page = nil, page_number = nil)
      @common_response.work do
        options = {}
        options[:size] = per_page if per_page
        options[:page] = page_number if page_number

        url = "#{@url}/catalog/content/#{@catalog_number}/"
        @common_response.data[:products] = get(url, options)['products']
      end
    end

    def find_product(product_id)
      @common_response.work do
        url = "#{@url}/catalog/product/#{@catalog_number}/#{product_id}"
        @common_response.data[:product] = get(url)['product']
      end
    end

    def shipping_options(params)
      @common_response.work do
        url = "#{@url}/order/shippingOptionsGet"
        @common_response.data[:shipping_options] =
          post(url, {}, params)['shippingOptions']
      end
    end

    def checkout(params)
      @common_response.work do
        url = "#{@url}/"
        @common_response.data[:checkout] = post(url, {}, params)
      end
    end

    private

    def get(url, options = {})
      uri = URI(url)
      hit(uri, options) do
        Net::HTTP.get_response(uri)
      end
    end

    def post(url, options = {}, body = {})
      uri = URI(url)
      hit(uri, options) do
        request = Net::HTTP::Post.new(uri)
        request.body = body.to_json
        request.content_type = 'application/json'
        Net::HTTP.start(uri.hostname) { |http| http.request(request) }
      end
    end

    def hit(uri, options = {})
      options.merge!(apiuser: @user, apikey: @api_key)
      uri.query = URI.encode_www_form(options)
      response = yield
      JSON.parse(response.body)
    end
  end
end
