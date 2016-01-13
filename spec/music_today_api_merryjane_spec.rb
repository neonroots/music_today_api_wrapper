require 'spec_helper'
require './lib/music_today_api_wrapper'
require './lib/resources/address'
require './lib/resources/purchase/item'
require './lib/resources/product'

describe 'test entire gem with merry jane products' do
  before :each do
    ENV['MUSIC_TODAY_DEPARTMENT_NAME'] = '222'
    ENV['MUSIC_TODAY_CATALOG_NAME'] = '111'
  end

  it 'should return merry jane products' do
    VCR.use_cassette('get_merry_jane_products') do
      response = MusicTodayApiWrapper.products
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      first_product = response.data[:products][0]
      expect(response.data[:products].length).to eq(42)
      expect(first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(first_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(first_product.name).to eq('Snoop Dogg Follow the BUSH T-shirt')
      expect(first_product.image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/NZCT022.JPG')
    end
  end

  it 'should return a product data' do
    VCR.use_cassette("get_product_merryjane") do
      response = MusicTodayApiWrapper.find_product('NZCT022')
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:product].class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(response.data[:product].image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(response.data[:product].name).to eq('Snoop Dogg Follow the BUSH T-shirt')
      expect(response.data[:product].image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/NZCT022.JPG')
    end
  end
end
