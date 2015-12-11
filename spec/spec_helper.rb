require 'rspec'
require './lib/music_today_api_wrapper'
require 'dotenv'

RSpec.configure do |config|
  config.before :all do
    Dotenv.load
  end
end
