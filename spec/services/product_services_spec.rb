require 'spec_helper'
require './lib/services/product_services'

describe 'Test project services for all products' do
  before do
    product_services = MusicTodayApiWrapper::Services::ProductServices.new
    VCR.use_cassette("get_products") do
      @response = product_services.all_products
      @first_product = @response.data[:products][0]
    end
  end

  it 'should return all products' do
    expect(@response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
    expect(@response.success?).to eq(true)
    expect(@response.data[:products].length).to eq(3)
  end

  it 'should return the right data types' do
    expect(@first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
    expect(@first_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
  end

  it 'should return the right name for products' do
    expect(@first_product.name).to eq('Amazing T-Shirt')
  end

  it 'should return the right id for products' do
    expect(@first_product.uid).to eq('AAA001')
  end
end

describe 'Test product services for pagination' do
  before do
    product_services = MusicTodayApiWrapper::Services::ProductServices.new
    VCR.use_cassette("get_products_filtered") do
      @response = product_services.all_products(2, 2)
      @first_product = @response.data[:products][0]
      @second_product = @response.data[:products][1]
    end
  end

  it 'should return the right data type' do
    expect(@response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
    expect(@first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
    expect(@first_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
    expect(@second_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
    expect(@second_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
  end

  it 'should return the right product amount' do
    expect(@response.data[:products].length).to eq(2)
  end

  it 'should return the right product ids' do
    expect(@first_product.uid).to eq('AAA002')
    expect(@second_product.uid).to eq('AAA003')
  end
end

describe 'Test product services for single product' do
  before do
    product_services = MusicTodayApiWrapper::Services::ProductServices.new
    VCR.use_cassette("get_product") do
      @response = product_services.find_product('AAA001')
      @product = @response.data[:product]
    end
  end

  it 'should return a common response with right data type' do
    expect(@response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
    expect(@product.class).to eq(MusicTodayApiWrapper::Resources::Product)
    expect(@product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
  end

  it 'should response success' do
    expect(@response.success?).to eq(true)
  end

  it 'should response the right product id' do
    expect(@product.uid).to eq('AAA001')
  end

  it 'should response the right variant data type' do
    variant = @product.variants.first
    expect(variant.class).to eq(MusicTodayApiWrapper::Resources::Variant)
  end

  it 'should response the right variant sku' do
    variant = @product.variants.first
    expect(variant.sku).to eq('AAA001SLBK')
  end

  it 'should response the right variant price' do
    variant = @product.variants.first
    expect(variant.price).to eq(24.99)
  end
end
