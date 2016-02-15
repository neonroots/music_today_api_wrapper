require 'spec_helper'
require './lib/music_today_api_wrapper'
require './lib/resources/address'
require './lib/resources/purchase/item'
require './lib/resources/product'
require './lib/resources/checkout/order'
require './lib/resources/checkout/billing/customer'
require './lib/resources/checkout/billing/payment'
require './lib/resources/checkout/destination'
require './lib/resources/purchase/invoice'

describe 'test the entire gem' do
  it 'should return the products list' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:products].length).to eq(3)
    end
  end

  it 'should return the products list with the right name data' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      first_product = response.data[:products][0]
      expect(first_product.name).to eq('Amazing T-Shirt')
    end
  end

  it 'should return the products list with the right images data small case' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      first_product = response.data[:products][0]
      expect(first_product.image.short).to eq('http://static.musictoday.com/store/bands/12/product_small/AAA001.JPG')
    end
  end

  it 'should return the products list with the right images data medium case' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      first_product = response.data[:products][0]
      expect(first_product.image.medium).to eq('http://static.musictoday.com/store/bands/12/product_medium/AAA001.JPG')
    end
  end

  it 'should return the products list with the right images data large case' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      first_product = response.data[:products][0]
      expect(first_product.image.medium).to eq('http://static.musictoday.com/store/bands/12/product_medium/AAA001.JPG')
    end
  end

  it 'should return the products in second page grouped by 2 products per page' do
    VCR.use_cassette("get_products_filtered") do
      response = MusicTodayApiWrapper.products(2, 2)

      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:products].length).to eq(2)
    end
  end

  it 'should return return the right data for first product paginated' do
    VCR.use_cassette("get_products_filtered") do
      response = MusicTodayApiWrapper.products(2, 2)

      first_product = response.data[:products][0]

      expect(first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(first_product.uid).to eq('AAA002')
      expect(first_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(first_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
    end
  end

  it 'should return return the right data for second product paginated' do
    VCR.use_cassette("get_products_filtered") do
      response = MusicTodayApiWrapper.products(2, 2)

      second_product = response.data[:products][1]

      expect(second_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(second_product.uid).to eq('AAA003')
      expect(second_product.class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(second_product.image.class).to eq(MusicTodayApiWrapper::Resources::Image)
    end
  end

  it 'should return the right variant sku' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      first_product = response.data[:products][0]
      first_variant = first_product.variants.first

      expect(first_product.variants.class).to eq(Array)
      expect(first_variant.sku).to eq('AAA001SLBK')
    end
  end

  it 'should return the right variant price' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      first_product = response.data[:products][0]
      first_variant = first_product.variants.first
      expect(first_variant.price).to eq(24.99)
    end
  end

  it 'should return the right variant amount' do
    VCR.use_cassette("get_products") do
      response = MusicTodayApiWrapper.products
      first_product = response.data[:products][0]
      first_variant = first_product.variants.first
      expect(first_variant.quantity_available).to eq(1299)
    end
  end

  it 'should return a product data' do
    VCR.use_cassette("get_product") do
      response = MusicTodayApiWrapper.find_product('AAA001')
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:product].class).to eq(MusicTodayApiWrapper::Resources::Product)
      expect(response.data[:product].image.class).to eq(MusicTodayApiWrapper::Resources::Image)
    end
  end

  it 'should return right product name' do
    VCR.use_cassette("get_product") do
      response = MusicTodayApiWrapper.find_product('AAA001')
      expect(response.data[:product].name).to eq('Amazing T-Shirt')
    end
  end

  it 'should return shipping options for a product' do
    VCR.use_cassette('get_shipping_options') do
      address =
        MusicTodayApiWrapper::Resources::Address.new('5391 Three Notched Road',
                                                     'Crozet',
                                                     'VA',
                                                     '22932')
      variant =
        MusicTodayApiWrapper::Resources::Variant.new('AAA002SLBK', 24.99, 1)
      item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant, 1)
      response = MusicTodayApiWrapper.shipping_options(address, [item])
      expect(response.data[:shipping_options][0].type).to eq('STANDARD')
      expect(response.data[:shipping_options][0].rate).to eq(6.29)
      expect(response.data[:shipping_options][0].description).to eq('Standard (5-9 business days)')
    end
  end

  it 'should return a checkout session with right data' do
    VCR.use_cassette('post_cart_pricing') do
      address =
        MusicTodayApiWrapper::Resources::Address.new('5391 Three Notched Road',
                                                     'Crozet',
                                                     'VA',
                                                     '22932',
                                                     'US',
                                                     '',
                                                     [],
                                                     'STANDARD')
      variant =
        MusicTodayApiWrapper::Resources::Variant.new('AAA002SLBK', 24.99, 1)

      item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant)
      response = MusicTodayApiWrapper.checkout(address, [item])
      expect(response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
      expect(response.success?).to eq(true)
      expect(response.data[:session].class).to eq(MusicTodayApiWrapper::Resources::Checkout::Session)
      expect(response.data[:session].id).to eq('FAKE-SESSION-NUMBER')
    end
  end
end

describe 'test purchase action without confirm prices' do
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
    payment =
      MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('4716938445825308',
                                                                      'fake name on card',
                                                                      2500, 2016, 2)
    variant =
     MusicTodayApiWrapper::Resources::Variant.new('AAA002SLBK', 24.99, 1)
    item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant, 1, nil, nil, 0)
    order =
      MusicTodayApiWrapper::Resources::Checkout::Order.new(customer,
                                                           payment,
                                                           [destination],
                                                           [item])
    VCR.use_cassette 'set_purchase' do
      @response = MusicTodayApiWrapper.purchase(order, false)
      @invoice = @response.data[:invoice]
    end
  end

  it 'should return a common_response' do
    expect(@response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
  end

  it 'should return a success common response' do
    expect(@response.success?).to eq(true)
  end

  it 'should return a an invoice' do
    expect(@invoice.class).to eq(MusicTodayApiWrapper::Resources::Purchase::Invoice)
  end

  it 'should return the shipping costs' do
    expect(@invoice.shipping).to eq(3.5)
  end

  it 'should return the sub total' do
    expect(@invoice.sub_total).to eq(14.95)
  end

  it 'should return the taxes' do
    expect(@invoice.taxes).to eq(0.98)
  end

  it 'should return the final total' do
    expect(@invoice.total).to eq(19.43)
  end

  it 'should return the right id' do
    expect(@invoice.id).to eq('123456789')
  end
end

describe 'test purchase action and confirm prices' do
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
    payment =
      MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('4716938445825308',
                                                                      'fake name on card',
                                                                      2500, 2016, 2)
    variant =
     MusicTodayApiWrapper::Resources::Variant.new('AAA002SLBK', 0.99, 1)
    item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant, 1, nil, nil, 0)
    order =
      MusicTodayApiWrapper::Resources::Checkout::Order.new(customer,
                                                           payment,
                                                           [destination],
                                                           [item])
    VCR.use_cassette 'set_purchase_with_confirm' do
      @response = MusicTodayApiWrapper.purchase(order)
      @invoice = @response.data[:invoice]
    end
  end

  it 'should return a common_response' do
    expect(@response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
  end

  it 'should return a success common response' do
    expect(@response.success?).to eq(true)
  end

  it 'should return a an invoice' do
    expect(@invoice.class).to eq(MusicTodayApiWrapper::Resources::Purchase::Invoice)
  end

  it 'should return the shipping costs' do
    expect(@invoice.shipping).to eq(3.5)
  end

  it 'should return the sub total' do
    expect(@invoice.sub_total).to eq(14.95)
  end

  it 'should return the taxes' do
    expect(@invoice.taxes).to eq(0.98)
  end

  it 'should return the final total' do
    expect(@invoice.total).to eq(19.43)
  end

  it 'should return the right id' do
    expect(@invoice.id).to eq('123456789')
  end
end

describe 'test purchase errors' do
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
    payment =
      MusicTodayApiWrapper::Resources::Checkout::Billing::Payment.new('4716938445825308',
                                                                      'fake name on card',
                                                                      2500, 2016, 2)
    variant =
     MusicTodayApiWrapper::Resources::Variant.new('AAA002SLBK', 0.99, 1)
    item = MusicTodayApiWrapper::Resources::Purchase::Item.new(variant, 1, nil, nil, 0)
    @order =
      MusicTodayApiWrapper::Resources::Checkout::Order.new(customer,
                                                           payment,
                                                           [destination],
                                                           [item])
  end

  context 'for fake address' do
    before do
      VCR.use_cassette 'set_purchase_address_length_error' do
        @response = MusicTodayApiWrapper.purchase(@order)
      end
    end

    it 'should return a common_response' do
      expect(@response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
    end

    it 'should return a common_response with errors' do
      expect(@response.success?).to eq(false)
    end

    it 'should return a common_response with address error' do
      expect(@response.errors[0]).to eq({ type: :address_error })
    end
  end

  context 'for fake card info' do
    before do
      VCR.use_cassette 'set_purchase_card_error' do
        @response = MusicTodayApiWrapper.purchase(@order)
      end
    end

    it 'should return a common_response' do
      expect(@response.class).to eq(MusicTodayApiWrapper::RestClients::CommonResponse)
    end

    it 'should return a common_response with errors' do
      expect(@response.success?).to eq(false)
    end

    it 'should return a common_response with address error' do
      expect(@response.errors[0]).to eq({ type: :credit_card_error })
    end
  end
end
