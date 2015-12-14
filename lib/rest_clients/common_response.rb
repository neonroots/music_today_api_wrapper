class CommonResponse
  attr_accessor :data, :errors

  def initialize(data = {}, errors = [])
    @data = data
    @errors = errors
  end

  def work
    yield
  rescue StandardError => error
    @errors.push(error.message)
  end

  def success?
    @errors.empty?
  end
end
