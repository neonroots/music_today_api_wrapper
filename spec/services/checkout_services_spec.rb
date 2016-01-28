require 'spec_helper'
require './lib/services/checkout_services'

describe 'Test checkout services features' do
  before do
    VCR.use_cassette('post_cart_pricing') do
      address =
        MusicTodayApiWrapper::Resources::Address.new('5391 Three Notched Road',
                                                     'Crozet',
                                                     'VA',
                                                     '22932')
      variant =
        MusicTodayApiWrapper::Resources::Variant.new('AAA002SLBK', 24.99, 1)

      item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant)
      checkout_services = MusicTodayApiWrapper::Services::CheckoutServices.new
      @response = checkout_services.checkout(address, [item])
    end
  end

  it 'should return a checkout session' do
    expect(@response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
    expect(@response.success?).to eq(true)
    expect(@response.data[:session].class).to eq(MusicTodayApiWrapper::Resources::Checkout::Session)
  end

  it 'should return a checkout session with right data' do
    expect(@response.data[:session].id).to eq('FAKE-SESSION-NUMBER')
  end
end
