require 'spec_helper'
require './lib/music_today_api_wrapper'

describe 'Test default configuration' do
  before :all do
    MusicTodayApiWrapper.configure do |config|
    end
  end

  it 'should set the default api key' do
    expect(MusicTodayApiWrapper.configuration.api_key).to eq(ENV['MUSIC_TODAY_API_KEY'])
  end

  it 'should set the default user' do
    expect(MusicTodayApiWrapper.configuration.user).to eq(ENV['MUSIC_TODAY_USER'])
  end

  it 'should set the default url' do
    expect(MusicTodayApiWrapper.configuration.url).to eq(ENV['MUSIC_TODAY_BASE_URL'])
  end
end

describe 'Test custom configuration' do
  it 'should set the custom api key' do
    MusicTodayApiWrapper.configure do |config|
      config.api_key = 'MY CUSTOM API KEY'
    end

    expect(MusicTodayApiWrapper.configuration.api_key).to eq('MY CUSTOM API KEY')
  end

  it 'should set the custom user' do
    MusicTodayApiWrapper.configure do |config|
      config.user = 'MY CUSTOM USER'
    end

    expect(MusicTodayApiWrapper.configuration.user).to eq('MY CUSTOM USER')
  end

  it 'should set the custom url' do
    MusicTodayApiWrapper.configure do |config|
      config.url = 'MY CUSTOM URL'
    end

    expect(MusicTodayApiWrapper.configuration.url).to eq('MY CUSTOM URL')
  end
end
