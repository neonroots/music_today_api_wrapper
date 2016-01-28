require 'spec_helper'
require './lib/resources/checkout/billing/payment'

describe 'check Payment hash structure' do
  before do
    payment =
    MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('4716938445825308',
                                                                    'fake name on card',
                                                                    2500,
                                                                    2016,
                                                                    2)
    @hash_payment = payment.as_hash
  end

  it 'as hash returns a hash object' do
    expect(@hash_payment.class).to eq(Hash)
  end

  it 'should returns a hash with the right credit card number' do
    expect(@hash_payment[:accountNumber]).to eq('4716938445825308')
  end

  it 'should returns a hash with the right customer name' do
    expect(@hash_payment[:nameOnCard]).to eq('fake name on card')
  end

  it 'should returns a hash with the right expiration year' do
    expect(@hash_payment[:expYear]).to eq(2016)
  end

  it 'should returns a hash with the right expiration month' do
    expect(@hash_payment[:expMonth]).to eq(2)
  end

  it 'should returns a hash with the right amount' do
    expect(@hash_payment[:amount]).to eq(2500.00)
  end
end

describe 'Check credit card type generation' do
  it 'should be a VISA' do
    payment =
    MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('4716938445825308',
                                                                    'fake name on card',
                                                                    2500,
                                                                    2016,
                                                                    2)
    hash_payment = payment.as_hash
    expect(hash_payment[:type]).to eq('VISA')
  end

  it 'should be a MasterCard' do
    payment =
    MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('5540326541016361',
                                                                    'fake name on card',
                                                                    2500,
                                                                    2016,
                                                                    2)
    hash_payment = payment.as_hash
    expect(hash_payment[:type]).to eq('MC')
  end

  it 'should be an AmericanExpress' do
    payment =
    MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('374169327978327',
                                                                    'fake name on card',
                                                                    2500,
                                                                    2016,
                                                                    2)
    hash_payment = payment.as_hash
    expect(hash_payment[:type]).to eq('AMEX')
  end

  it 'should be an Discover' do
    payment =
    MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('6011925167693169',
                                                                    'fake name on card',
                                                                    2500,
                                                                    2016,
                                                                    2)
    hash_payment = payment.as_hash
    expect(hash_payment[:type]).to eq('DISCOVER')
  end
end
