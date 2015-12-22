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

  it 'should return the products in second page grouped by 2 products per page' do
    VCR.use_cassette("get_products_filtered") do
      response = MusicTodayApiWrapper.products(2, 2)

      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:products].length).to eq(2)

      first_product = response.data[:products][0]
      second_product = response.data[:products][1]

      expect(first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(first_product.uid).to eq('DM396COMBO')
      expect(first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(first_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(first_product.name).to eq("Live Trax Vol. 35 Women's T-shirt Bundle")
      expect(first_product.image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/DM396COMBO.JPG')

      expect(second_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(second_product.uid).to eq('DM397COMBO')
      expect(second_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(second_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(second_product.name).to eq('DMB Live Trax Vol. 35 + Tee + Metal Sign Bundle')
      expect(second_product.image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/DM397COMBO.JPG')
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
      expect(response.data[:shipping_options][0].rate).to eq(14.11)
      expect(response.data[:shipping_options][0].description).to eq('Expedited (3-7 business days; Not guaranteed for Christmas delivery.)')
    end
  end

  it 'should return a checkout session with right data' do
    VCR.use_cassette('post_cart_pricing') do
      address =
        MusicTodayApiWrapper::Resources::Address.new('2 Lexington Avenue',
                                                     'Crozet',
                                                     'VA',
                                                     '22932')
      variant =
        MusicTodayApiWrapper::Resources::Variant.new('DMAM539',100, 14.5)

      item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant)
      response = MusicTodayApiWrapper.checkout(address, [item])
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:session].class).to eq(MusicTodayApiWrapper::Resources::Checkout::Session)
      expect(response.data[:session].id).to eq('03b501ca-f0a7-4733-958a-e3402082e851')
    end
  end
end
