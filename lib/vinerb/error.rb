class Vinerb::Error < StandardError
  attr_accessor :code

  def initialize(message, code = nil)
    super(message)
    @code = code
  end
end
