require 'spec_helper'
require './lib/resources/checkout/order'
require './lib/resources/checkout/billing/customer'
require './lib/resources/checkout/billing/payment'
require './lib/resources/address'
require './lib/resources/checkout/destination'
require './lib/resources/purchase/item'

describe 'check Order hash structure' do
  before do
    address =
      MusicTodayApiWrapper::Resources::Address.new('2209 Elk Rd Little',
                                                   'AZ',
                                                   'Tucson',
                                                   '85704')
    destination =
      MusicTodayApiWrapper::Resources::Checkout::Destination.new(address, 'CHEAPEST', 250)
    payment =
      MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('4716938445825308',
                                                                      'fake name on card',
                                                                      2500, 2016, 2)
    customer =
      MusicTodayApiWrapper::Resources::Checkout::Billing::Customer.new('fake_name',
                                                                       'fake_surname',
                                                                       'Nye Regional Medical Center',
                                                                       'Chicago',
                                                                       'IL',
                                                                       '22699',
                                                                       '12-456-7890',
                                                                       'fake@email.com')
    variant =
     MusicTodayApiWrapper::Resources::Variant.new('AAA002SLBK', 24.99, 1)
    item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant, 1, nil, nil, 0)
    order =
      MusicTodayApiWrapper::Resources::Checkout::Order.new(customer,
                                                           payment,
                                                           [destination],
                                                           [item])
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

  it 'as hash returns the right destinations' do
    expect(@hash_order[:destinations][0][:requestedShippingOption]).to eq('CHEAPEST')
  end

  it 'as hash returns the right items' do
    expect(@hash_order[:lineItems][0][:destIndex]).to eq(0)
  end

  it 'as hash returns the right promotions' do
    expect(@hash_order[:promotions]).to eq([])
  end
end
