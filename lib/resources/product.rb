require 'resources/image'

module MusicTodayApiWrapper
  module Resources
    class Product
      attr_accessor :uid, :name, :description, :category, :image, :price

      # rubocop:disable ParameterLists
      def initialize(uid, name, description, category, price,
        image = MusicTodayApiWrapper::Resources::Image.new)
        @uid = uid
        @name = name
        @description = description
        @category = category
        @price = price
        @image = image
      end

      def self.from_hash(product_hash)
        image = Image.new(product_hash['imageUrlSmall'],
                          product_hash['imageUrlMedium'],
                          product_hash['imageUrlLarge'])

        Product.new(product_hash['id'],
                    product_hash['name'],
                    product_hash['lang']['en']['textDesc'],
                    product_hash['categoryName'],
                    product_hash['listPrice'],
                    image)
      end
    end
  end
end
