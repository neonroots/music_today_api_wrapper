require 'spec_helper'
require './lib/resources/checkout/order'

describe 'check Order hash structure' do
  before do
    order = MusicTodayApiWrapper::Resources::Checkout::Order.new
    @hash_order = order.as_hash
  end

  it 'as hash returns a hash object' do
    expect(@hash_order.class).to eq(Hash)
  end

  it 'as hash returns the right store' do
    expect(@hash_order[:storeId]).to eq(12)
  end

  it 'as hash returns the right channel' do
    expect(@hash_order[:channel]).to eq('fake_channel')
  end

  it 'as hash returns the right currency' do
    expect(@hash_order[:currency]).to eq('USD')
  end
end
