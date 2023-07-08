class NumberValidator < BaseValidator
  def initialize(field_name)
    @supporting_validations = [:min, :max, :between, :in, :eq]
    
    validator = -> (v) { [Integer, Float].include? v.class }

    err = "#{field_name} is not valid number"

    @validations = [validation_func(validator, err)]
  end

  def validate_min(field_name, min)
    validator = -> (v) { v >= min }

    err = "#{field_name} cannot be less than #{min}"

    @validations << validation_func(validator, err)
  end
  
  def validate_max(field_name, max)
    validator = -> (v) { v <= max }

    err = "#{field_name} cannot be bigger than #{max}"

    @validations << validation_func(validator, err)
  end
  
  def validate_between(field_name, max)
    validator = -> (v) { v >= min && v <= max }

    err = "#{field_name} has to be between #{min} and #{max}"

    @validations << validation_func(validator, err)
  end
end