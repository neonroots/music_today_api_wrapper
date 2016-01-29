require 'spec_helper'
require './lib/resources/checkout/billing/payment'

def get_payment(card_type)
  card_number = case card_type
  when 'VISA'
    '4716938445825308'
  when 'MASTERCARD'
    '5540326541016361'
  when 'AMEX'
    '374169327978327'
  when 'DISCOVER'
    '6011925167693169'
  end
  MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new(card_number,
    'fake name on card', 2500, 2016, 2)
end

describe 'check Payment hash structure' do
  before do
    payment = get_payment('VISA')
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
    payment = get_payment('VISA')
    hash_payment = payment.as_hash
    expect(hash_payment[:type]).to eq('VISA')
  end

  it 'should be a MasterCard' do
    payment = get_payment('MASTERCARD')
    hash_payment = payment.as_hash
    expect(hash_payment[:type]).to eq('MC')
  end

  it 'should be an AmericanExpress' do
    payment = get_payment('AMEX')
    hash_payment = payment.as_hash
    expect(hash_payment[:type]).to eq('AMEX')
  end

  it 'should be an Discover' do
    payment = get_payment('DISCOVER')
    hash_payment = payment.as_hash
    expect(hash_payment[:type]).to eq('DISCOVER')
  end
end
