class RegexValidator < BaseValidator
  def initialize
    super()

    @supporting_validations = [:regex]
  end

  def validate_regex(field_name, regex)
    validator = -> (v) { regex.match(v) }
    
    err = "#{field_name} does not match"

    @validations << validation_func(validator, err)
  end
end