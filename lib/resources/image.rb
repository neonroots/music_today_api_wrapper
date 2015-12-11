class Image
  attr_accessor :short, :medium, :large

  def initialize(short = nil, medium = nil, large = nil)
    @short = short
    @medium = medium
    @large = large
  end
end
