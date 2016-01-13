require 'rspec'
require './lib/music_today_api_wrapper'
require 'dotenv'
require 'vcr'
require 'byebug'

RSpec.configure do |config|
  config.before :each do
    Dotenv.load
    ENV['MUSIC_TODAY_DEPARTMENT_NAME'] = nil
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/vcr_cassettes"
  config.hook_into :webmock
end
