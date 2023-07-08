class ArrayValidator < BaseValidator
  def initialize(field_name)
    @supporting_validations = [:of, :length, :min_length, :max_length, :in, :eq]

    validator = -> (v) { v.class == Array }
    
    err = "#{field_name} is not valid array"
    
    @validations = [validation_func(validator, err)]
  end

  def validate_of(field_name, types)
    types = [types] unless types.class == Array
    
    types = types.map { |type| type.class == Symbol ? Kernel.const_get(type.to_s.capitalize) : type }

    validator = -> (values) { values.all? { |v| types.include? v.class } }

    err = "#{field_name} has to be of type #{types}"

    @validations << validation_func(validator, err)
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

  def validate_eq(field_name, eq)
    validator = -> (v) { (v.to_set - eq.to_set).length == 0 }

    err = "#{field_name} has to be equal to #{eq}"

    @validations << validation_func(validator, err)
  end
  
  def validate_in(field_name, in_arr)
    validator = -> (v) { (in_arr.to_set.intersection(v.to_set)).length === v.to_set.length }

    err = "#{field_name} is not included in #{in_arr}"

    @validations << validation_func(validator, err)
  end
end