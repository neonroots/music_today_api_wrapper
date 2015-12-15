require 'spec_helper'
require './lib/rest_clients/common_response'

describe 'Check common response structure' do
  it 'when block is called with an ex should send a error message and success false' do
    common_response = MusicTodayApiWrapper::RestClients::CommonResponse.new
    common_response.work do
      raise 'My new type of exception'
    end
    expect(common_response.errors[0]).to eq('My new type of exception')
  end

  it 'when block is called with right data should send the data and success true' do
    common_response = MusicTodayApiWrapper::RestClients::CommonResponse.new
    common_response.work do
      common_response.data[:pablo] = 'Gonzaga'
    end
    expect(common_response.errors.length).to eq(0)
    expect(common_response.data[:pablo]).to eq('Gonzaga')
  end
end
