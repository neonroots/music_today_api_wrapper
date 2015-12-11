require './lib/resources/image'

class Product
  attr_accessor :name, :description, :category, :image

  def initialize(name, description, category, image = Image.new)
    @name = name
    @description = description
    @category = category
    @image = image
  end
end
