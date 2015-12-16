require 'support/configuration'
require 'services/product_services'

module MusicTodayApiWrapper
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.products
    product_services = Services::ProductServices.new
    product_services.all_products
  end

  def self.find_product(id)
    product_services = Services::ProductServices.new
    product_services.find_product(id)
  end
end
