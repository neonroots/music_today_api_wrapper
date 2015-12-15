require 'spec_helper'
require './lib/resources/product'

describe 'check Product structure' do
  it 'intialized works correctly' do
    product = MusicTodayApiWrapper::Resources::Product.new('80',
                                                           'product-name',
                                                           'product-description',
                                                           'product-category',
                                                           13.5)
    expect(product.uid).to eq('80')
    expect(product.name).to eq('product-name')
    expect(product.description).to eq('product-description')
    expect(product.category).to eq('product-category')
    expect(product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
    expect(product.price).to eq(13.5)
  end
end
