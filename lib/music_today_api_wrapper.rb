require 'support/configuration'
require 'domain/product_services'

module MusicTodayApiWrapper
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.products
    product_services = Domain::ProductServices.new
    product_services.all_products
  end
end
