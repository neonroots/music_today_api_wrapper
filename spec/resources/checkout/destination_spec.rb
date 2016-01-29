require 'spec_helper'
require './lib/resources/address'
require './lib/resources/checkout/destination'

describe 'check Destination hash structure' do
  before do
    address =
      MusicTodayApiWrapper::Resources::Address.new('2209 Elk Rd Little',
                                                   'AZ',
                                                   'Tucson',
                                                   '85704')
    destination =
      MusicTodayApiWrapper::Resources::Checkout::Destination.new(address, 'CHEAPEST', 250)
    @hash_destination = destination.as_hash
  end

  it 'should return the right shipping option' do
    expect(@hash_destination[:requestedShippingOption]).to eq('CHEAPEST')
  end

  it 'should return the right shipping cost' do
    expect(@hash_destination[:shippingCost]).to eq(250.00)
  end

  it 'should return the right shipping address street' do
    expect(@hash_destination[:address][:street]).to eq('2209 Elk Rd Little')
  end

  it 'should return the right shipping address state' do
    expect(@hash_destination[:address][:state]).to eq('AZ')
  end

  it 'should return the right shipping address city' do
    expect(@hash_destination[:address][:city]).to eq('Tucson')
  end

  it 'should return the right shipping address city' do
    expect(@hash_destination[:address][:postalCode]).to eq('85704')
  end
end
