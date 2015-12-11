module MusicTodayApiWrapper
  class Configuration
    attr_accessor :user, :api_key, :url

    def initialize
      @user = ENV['MUSIC_TODAY_USER']
      @api_key = ENV['MUSIC_TODAY_API_KEY']
      @url = ENV['MUSIC_TODAY_BASE_URL']
    end
  end
end
