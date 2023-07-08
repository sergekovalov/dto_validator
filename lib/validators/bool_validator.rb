class BoolValidator < BaseValidator
  def initialize(field_name)
    super()

    validator = -> (v) { [TrueClass, FalseClass].include? v.class }
    
    err = "#{field_name} is not valid boolean"
    
    @validations = [validation_func(validator, err)]
  end
end