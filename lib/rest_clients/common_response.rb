class CommonResponse
  attr_accessor :data, :errors

  def initialize(data = {}, errors = [])
    @data = data
    @errors = errors
  end

  def work
    yield
    self
  rescue StandardError => error
    @errors.push(error.message)
    self
  end

  def success?
    @errors.empty?
  end
end
