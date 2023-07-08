class BaseValidator
  attr_reader :supporting_validations

  def initialize
    @supporting_validations = [:in, :eq]

    @validations = []
  end

  def validation_func(condition, err)
    f = Proc.new do |v|
      res = condition.call(v)

      err unless res
    end

    return f
  end

  def supports_validation?(validation)
    @supporting_validations.include? validation.to_sym
  end
  
  def validate(field_name, value)
    @validations.each do |validation|
      err = validation.call(value)

      return err if err
    end

    nil
  end

  def validate!
    @validations.each do |validation|
      err = validation.call(field_name, value)

      raise err if err
    end

    nil
  end

  def validate_required(field_name)
    validator = -> (v) { v != nil }

    err = "#{field_name} is a required parameter"

    @validations << validation_func(validator, err)
  end

  def validate_in(field_name, in_arr)
    validator = -> (v) { in_arr.include? v }

    err = "#{field_name} is not included in #{in_arr}"

    @validations << validation_func(validator, err)
  end
  
  def validate_eq(field_name, eq)
    validator = -> (v) { eq == v }

    err = "#{field_name} has to be equal to #{eq}"

    @validations << validation_func(validator, err)
  end
end