class StringValidator < RegexValidator
  def initialize(field_name)
    super()

    @supporting_validations = [:length, :min_length, :max_length, :not_empty, :not_empty_strip, :regex, :in, :eq]
    
    validator = -> (v) { v.class == String }
    
    err = "#{field_name} is not valid string"
    
    @validations = [validation_func(validator, err)]
  end

  def validate_length(field_name, length)
    validator = -> (v) { v.length == length }
    
    err = "#{field_name} has to have a length = #{length}"
    
    @validations = [validation_func(validator, err)]
  end
  
  def validate_min_length(field_name, length)
    validator = -> (v) { v.length >= length }
    
    err = "#{field_name} length cannot be less than #{length}"
    
    @validations = [validation_func(validator, err)]
  end
  
  def validate_max_length(field_name, length)
    validator = -> (v) { v.length <= length }
    
    err = "#{field_name} length cannot be greater than #{length}"
    
    @validations = [validation_func(validator, err)]
  end
  
  def validate_not_empty(field_name, should_validate_is_not_empty)
    validator = -> (v) { should_validate_is_not_empty ? v.length > 0 : true }
    
    err = "#{field_name} should not be empty"
    
    @validations = [validation_func(validator, err)]
  end
  
  def validate_not_empty_strip(field_name, should_validate_is_not_empty)
    validator = -> (v) { should_validate_is_not_empty ? v.strip.length > 0 : true }
    
    err = "#{field_name} should not be empty"
    
    @validations = [validation_func(validator, err)]
  end
end