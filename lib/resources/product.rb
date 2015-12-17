require 'resources/image'

module MusicTodayApiWrapper
  module Resources
    class Product
      attr_accessor :uid,
                    :parent_id,
                    :name,
                    :description,
                    :category,
                    :image,
                    :price

      # rubocop:disable ParameterLists
      def initialize(uid, parent_id, name, description, category, price,
        image = MusicTodayApiWrapper::Resources::Image.new)
        @uid = uid
        @parent_id = parent_id
        @name = name
        @description = description
        @category = category
        @price = price
        @image = image
      end

      def self.from_hash(product)
        image = Image.new(product['imageUrlSmall'],
                          product['imageUrlMedium'],
                          product['imageUrlLarge'])
        variants = []
        product['variants'].each do |variant|
          variants << variant_from_hash(product, variant, image)
        end
        variants
      end

      def self.variant_from_hash(product_hash, variant_hash, image)
        Product.new(variant_hash['sku'],
                    product_hash['id'],
                    product_hash['name'],
                    product_hash['lang']['en']['textDesc'],
                    product_hash['categoryName'],
                    variant_hash['listPrice'],
                    image)
      end
    end
  end
end
