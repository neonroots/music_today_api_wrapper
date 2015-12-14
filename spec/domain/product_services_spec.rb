require 'spec_helper'
require './lib/domain/product_services'

describe 'Test project services features' do
  before do
    @product_services = MusicTodayApiWrapper::ProductServices.new
  end

  it 'should return all products' do
    VCR.use_cassette("get_products") do
      response = @product_services.all_products

      expect(response.class).to eq(CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:products].length).to eq(9)
      expect(response.data[:products][0].class).to eq(Product)
      expect(response.data[:products][0].image.class).to eq(Image)
      expect(response.data[:products][0].name).to eq('DMB Live Trax Vol. 35: Post-Gazette Pavilion')
      expect(response.data[:products][0].image.short).to eq('http://static.musictoday.com/store/bands/93/product_small/POTSGAZETTE.JPG')
    end
  end
end
