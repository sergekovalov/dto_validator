class FloatValidator < NumberValidator
  def initialize(field_name)
    super(field_name)

    validator = -> (v) { v.class == Float }
    
    err = "#{field_name} is not valid float"
    
    @validations = [validation_func(validator, err)]
  end
end
