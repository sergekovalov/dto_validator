class IntegerValidator < NumberValidator
  def initialize(field_name)
    super(field_name)

    validator = -> (v) { v.class == Integer }
    
    err = "#{field_name} is not valid integer"
    
    @validations = [validation_func(validator, err)]
  end
end