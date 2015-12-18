require 'resources/image'
require 'resources/variant'

module MusicTodayApiWrapper
  module Resources
    class Product
      attr_accessor :uid,
                    :name,
                    :description,
                    :category,
                    :image,
                    :price,
                    :variants

      # rubocop:disable ParameterLists
      def initialize(uid, name, description, category, price,
        image = MusicTodayApiWrapper::Resources::Image.new, variants = [])
        @uid = uid
        @name = name
        @description = description
        @category = category
        @price = price
        @image = image
        @variants = variants
      end

      # rubocop:disable AbcSize
      def self.from_hash(hash)
        image = Image.new(hash['imageUrlSmall'],
                          hash['imageUrlMedium'],
                          hash['imageUrlLarge'])

        product = Product.new(hash['id'],
                              hash['name'],
                              hash['lang']['en']['textDesc'],
                              hash['categoryName'],
                              hash['listPrice'],
                              image)

        hash['variants'].each do |variant|
          product.variants << Variant.from_hash(variant)
        end
        product
      end
    end
  end
end
