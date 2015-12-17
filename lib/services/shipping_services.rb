require 'rest_clients/music_today_rest_client'

module MusicTodayApiWrapper
  module Services
    class ShippingServices
      def initialize
        @common_response =
          MusicTodayApiWrapper::RestClients::CommonResponse.new
        @rest_client = MusicTodayApiWrapper::RestClient.new
      end
    end
  end
end
