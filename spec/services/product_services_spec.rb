require 'spec_helper'
require './lib/services/product_services'

describe 'Test project services features' do
  before do
    @product_services = MusicTodayApiWrapper::Services::ProductServices.new
  end

  it 'should return all products' do
    VCR.use_cassette("get_products") do
      response = @product_services.all_products

      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:products].length).to eq(9)

      first_product = response.data[:products][0]

      expect(first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(first_product.uid).to eq('DMDD132')
      expect(first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(first_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(first_product.name).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
      expect(first_product.image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/POTSGAZETTE.JPG')
    end
  end

  it 'should return the products in second page grouped by 2 products per page' do
    VCR.use_cassette("get_products_filtered") do
      response = @product_services.all_products(2, 2)

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

  it 'should return product data' do
    VCR.use_cassette("get_product") do
      response = @product_services.find_product('DMDD132')

      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      product = response.data[:product]

      expect(product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
      expect(product.name).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
      expect(product.image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/POTSGAZETTE.JPG')
    end
  end

  it 'should return the right variant data' do
    VCR.use_cassette("get_product") do
      response = @product_services.find_product('DMDD132')

      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)

      variant = response.data[:product].variants.first

      expect(variant.class).to eq(MusicTodayApiWrapper::Resources::Variant)
      expect(variant.sku).to eq('DMCD123')
      expect(variant.price).to eq(15.99)
      expect(variant.quantity_available).to eq(99999)
      expect(variant.variant_names[0][:format]).to eq('CD')
      expect(variant.variant_names[1][:bitrate]).to eq('16 bit')
    end
  end
end
