require 'support/configuration'
require 'services/product_services'
require 'services/shipping_services'

module MusicTodayApiWrapper
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.products(per_page = nil, page_number = nil)
    product_services = Services::ProductServices.new
    product_services.all_products(per_page, page_number)
  end

  def self.find_product(id)
    product_services = Services::ProductServices.new
    product_services.find_product(id)
  end

  def self.shipping_options(address, items)
    shipping_services = Services::ShippingServices.new
    shipping_services.options(address, items)
  end
end
