class ValidationError < StandardError
  attr_reader :field
  def initialize(field)
    @field = field
    super("Validation for :#{field} is already defined")
  end
end