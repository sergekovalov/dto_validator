module Utils
  def map_validator(type)
    case type
    when :any
      AnyValidator
    when :number
      NumberValidator
    when :integer
      IntegerValidator
    when :float
      FloatValidator
    when :string
      StringValidator
    when :regex
      RegexValidator
    when :email
      EmailValidator
    when :bool
      BoolValidator
    when :array
      ArrayValidator
    when :hash
      HashValidator
    when :json
      JsonValidator
    else
      raise "Cannot define a validator for type #{type}"
    end
  end
end

def load_validators!
  files = Dir.entries('lib/validators').select{|file_name| file_name.end_with? ".rb"}

  files.each do |file_name|
    validator_name = file_name.split('_').map{|s| s.sub(/\.rb$/, '').capitalize}.join('').to_sym

    autoload(validator_name, "validators/#{file_name}")
  end
end
