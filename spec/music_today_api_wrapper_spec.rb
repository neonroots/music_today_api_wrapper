require 'spec_helper'
require './lib/music_today_api_wrapper'
require './lib/resources/address'
require './lib/resources/purchase/item'
require './lib/resources/product'

describe 'test the entire gem' do
  it 'should return the products list' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:products].length).to eq(69)
      expect(response.data[:products][0].class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(response.data[:products][0].image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(response.data[:products][0].name).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
      expect(response.data[:products][0].image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/POTSGAZETTE.JPG')
    end
  end

  it 'should return a product data' do
    VCR.use_cassette("get_product") do
      response = MusicTodayApiWrapper.find_product('DMDD132', 'DMDD132FL15')
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:product].class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(response.data[:product].image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(response.data[:product].name).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
      expect(response.data[:product].image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/POTSGAZETTE.JPG')
    end
  end

  it 'should return shipping options for a product' do
    VCR.use_cassette('get_shipping_options') do
      address =
        MusicTodayApiWrapper::Resources::Address.new('2 Lexington Avenue, New York, NY',
                                                     'Crozet',
                                                     'VA',
                                                     '22932')
      product =
        MusicTodayApiWrapper::Resources::Product.new('DMAM539', 'DMAM539',
          'lorem', 'lorem ipsum', 'lorem ipsum', 14.5)

      item = MusicTodayApiWrapper::Resources::Purchase::Item.new(product, 2)
      response = MusicTodayApiWrapper.shipping_options(address, [item])
      expect(response.data[:shipping_options][0].type).to eq('STANDARD')
      expect(response.data[:shipping_options][0].rate).to eq(6.29)
      expect(response.data[:shipping_options][0].description).to eq('Standard (Ships in time for Christmas delivery)')
    end
  end
end
