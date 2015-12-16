require 'spec_helper'
require './lib/rest_clients/music_today_rest_client'

describe 'check Music Today rest cliente features' do
  before do
    @music_today_rest_client = MusicTodayApiWrapper::RestClient.new
  end

  it 'should return product list json' do
    VCR.use_cassette("get_products") do
      common_response = @music_today_rest_client.all_products
      expect(common_response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(common_response.data[:products].class).to eq(Array)
      expect(
        common_response.data[:products][0]['name']
      ).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
    end
  end

  it 'should return product list json' do
    VCR.use_cassette("get_product") do
      common_response = @music_today_rest_client.find_product('DMDD132')
      expect(common_response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(common_response.data[:product].class).to eq(Hash)
      expect(
        common_response.data[:product]['name']
      ).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
    end
  end
end
