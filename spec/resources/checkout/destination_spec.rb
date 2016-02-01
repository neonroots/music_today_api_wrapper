require 'spec_helper'
require './lib/resources/address'
require './lib/resources/checkout/destination'

describe 'check Destination hash structure' do
  before do
    customer =
    MusicTodayApiWrapper::Resources::Checkout::Billing::Customer.new('fake_name',
                                                                     'fake_surname',
                                                                     'Nye Regional Medical Center',
                                                                     'Chicago',
                                                                     'IL',
                                                                     '22699',
                                                                     '12-456-7890',
                                                                     'fake@email.com')
    destination =
      MusicTodayApiWrapper::Resources::Checkout::Destination.new(customer, 'CHEAPEST', 250)
    @hash_destination = destination.as_hash
  end

  it 'should return the right shipping option' do
    expect(@hash_destination[:requestedShippingOption]).to eq('CHEAPEST')
  end

  it 'should return the right shipping cost' do
    expect(@hash_destination[:shippingCost]).to eq(250.00)
  end

  it 'should return the right shipping address street' do
    expect(@hash_destination[:address][:street]).to eq('Nye Regional Medical Center')
  end

  it 'should return the right shipping address state' do
    expect(@hash_destination[:address][:state]).to eq('IL')
  end

  it 'should return the right shipping address city' do
    expect(@hash_destination[:address][:city]).to eq('Chicago')
  end

  it 'should return the right shipping address city' do
    expect(@hash_destination[:address][:postalCode]).to eq('22699')
  end
end
