class HashValidator < RegexValidator
  def initialize(field_name)
    super()

    @supporting_validations = [:eq, :dto]
    
    validator = -> (v) { v.class == Hash }
    
    err = "#{field_name} is not valid JSON/Hash"
    
    @validations = [validation_func(validator, err)]
  end

  def validate_eq(field_name, eq)
    validator = -> (v) { eq == v }

    err = "#{field_name} has to be equal to #{eq}"

    @validations << validation_func(validator, err)
  end

  def validate_dto(field_name, dto)
    validator = -> (v) do
      res, erros = dto.new(v).validate
      
      res
    end

    err = "#{field_name} validation did not pass"

    @validations << validation_func(validator, err)
  end
end