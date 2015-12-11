require 'spec_helper'
require './lib/resources/product'

describe 'check Product structure' do
  it 'intialized works correctly' do
    product = Product.new('product-name',
                          'product-description',
                          'product-category')
    expect(product.name).to eq('product-name')
    expect(product.description).to eq('product-description')
    expect(product.category).to eq('product-category')
    expect(product.image.class).to eq(Image)
  end
end
