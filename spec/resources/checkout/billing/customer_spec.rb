require 'spec_helper'
require './lib/resources/checkout/billing/customer'

describe 'check Customer hash structure' do
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
    @hash_customer = customer.as_hash
  end

  it 'as hash returns a hash object' do
    expect(@hash_customer.class).to eq(Hash)
  end

  it 'should return a hash with US as country' do
    expect(@hash_customer[:country]).to eq('US')
  end

  it 'should return a hash with the right name' do
    expect(@hash_customer[:firstName]).to eq('fake_name')
  end

  it 'should return a hash with the right surname' do
    expect(@hash_customer[:lastName]).to eq('fake_surname')
  end

  it 'should return a hash with the right street' do
    expect(@hash_customer[:street]).to eq('Nye Regional Medical Center')
  end

  it 'should return a hash with the right city' do
    expect(@hash_customer[:city]).to eq('Chicago')
  end

  it 'should return a hash with the right state' do
    expect(@hash_customer[:state]).to eq('IL')
  end

  it 'should return a hash with the right zip code' do
    expect(@hash_customer[:postalCode]).to eq('22699')
  end

  it 'should return a hash with the right phone' do
    expect(@hash_customer[:phone]).to eq('12-456-7890')
  end

  it 'should return a hash with the right phone' do
    expect(@hash_customer[:email]).to eq('fake@email.com')
  end
end
