require 'rspec'
require './lib/music_today_api_wrapper'
require 'dotenv'
require 'vcr'

RSpec.configure do |config|
  config.before :all do
    Dotenv.load
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/vcr_cassettes"
  config.hook_into :webmock
end
