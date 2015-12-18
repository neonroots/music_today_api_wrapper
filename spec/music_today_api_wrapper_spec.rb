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
      first_product = response.data[:products][0]
      expect(response.data[:products].length).to eq(9)
      expect(first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(first_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(first_product.name).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
      expect(first_product.image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/POTSGAZETTE.JPG')
    end
  end

  it 'should return the right variant' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      first_product = response.data[:products][0]
      first_variant = first_product.variants.first

      expect(first_product.variants.class).to eq(Array)
      expect(first_variant.sku).to eq('DMCD123')
      expect(first_variant.price).to eq(15.99)
      expect(first_variant.quantity_available).to eq(99999)
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

  it 'should return shipping options for a product' do
    VCR.use_cassette('get_shipping_options') do
      address =
        MusicTodayApiWrapper::Resources::Address.new('2 Lexington Avenue, New York, NY',
                                                     'Crozet',
                                                     'VA',
                                                     '22932')
      variant =
        MusicTodayApiWrapper::Resources::Variant.new('DMAM539',100, 14.5)

      item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant, 2)
      response = MusicTodayApiWrapper.shipping_options(address, [item])
      expect(response.data[:shipping_options][0].type).to eq('EXPEDITED')
      expect(response.data[:shipping_options][0].rate).to eq(6.29)
      expect(response.data[:shipping_options][0].description).to eq('Standard (Ships in time for Christmas delivery)')
    end
  end
end
