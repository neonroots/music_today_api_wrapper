require 'spec_helper'
require './lib/services/checkout_services'

describe 'Test checkout services features' do
  it 'should return a checkout session with right data' do
    VCR.use_cassette('post_cart_pricing') do
      address =
        MusicTodayApiWrapper::Resources::Address.new('2 Lexington Avenue',
                                                     'Crozet',
                                                     'VA',
                                                     '22932')
      variant =
        MusicTodayApiWrapper::Resources::Variant.new('DMAM539',100, 14.5)

      item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant)
      checkout_services = MusicTodayApiWrapper::Services::CheckoutServices.new
      response = checkout_services.checkout(address, [item])
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:session].class).to eq(MusicTodayApiWrapper::Resources::Checkout::Session)
      expect(response.data[:session].id).to eq('03b501ca-f0a7-4733-958a-e3402082e851')
    end
  end
end
