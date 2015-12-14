require './lib/resources/image'

class Product
  attr_accessor :name, :description, :category, :image

  def initialize(name, description, category, image = Image.new)
    @name = name
    @description = description
    @category = category
    @image = image
  end

  def self.from_hash(product_hash)
    image = Image.new(product_hash['imageUrlSmall'],
                      product_hash['imageUrlMedium'],
                      product_hash['imageUrlLarge'])

    Product.new(product_hash['name'], product_hash['lang']['en']['textDesc'],
      product_hash['categoryName'], image)
  end
end
