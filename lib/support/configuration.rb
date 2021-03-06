module MusicTodayApiWrapper
  class Configuration
    attr_accessor :user,
                  :api_key,
                  :url,
                  :catalog,
                  :department,
                  :channel,
                  :order_prefix

    def initialize
      @user = ENV['MUSIC_TODAY_USER']
      @api_key = ENV['MUSIC_TODAY_API_KEY']
      @url = ENV['MUSIC_TODAY_BASE_URL']
      @catalog = ENV['MUSIC_TODAY_CATALOG_NAME']
      @department = ENV['MUSIC_TODAY_DEPARTMENT_NAME'] || nil
      @channel = ENV['MUSIC_TODAY_CHANNEL'] || ''
      @order_prefix = ENV['MUSIC_TODAY_ORDER_PREFIX'] || 'EXA'
    end
  end
end
