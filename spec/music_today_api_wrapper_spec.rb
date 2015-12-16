require 'spec_helper'
require './lib/music_today_api_wrapper'

describe 'test the entire gem' do
  it 'should return the products list' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:products].length).to eq(9)
      expect(response.data[:products][0].class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(response.data[:products][0].image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(response.data[:products][0].name).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
      expect(response.data[:products][0].image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/POTSGAZETTE.JPG')
    end
  end

  it 'should return a product data' do
    VCR.use_cassette("get_product") do
      response = MusicTodayApiWrapper.find_product('DMDD132')
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:product].class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(response.data[:product].image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(response.data[:product].name).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
      expect(response.data[:product].image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/POTSGAZETTE.JPG')
    end
  end
end
