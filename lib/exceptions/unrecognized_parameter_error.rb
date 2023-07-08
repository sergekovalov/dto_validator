class UnrecognizedParameterError < StandardError
  attr_reader :key
  def initialize(key)
    @key = key
    super("Unrecognized parameter '#{key}'")
  end
end