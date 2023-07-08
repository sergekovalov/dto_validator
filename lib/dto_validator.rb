# frozen_string_literal: true
require 'json'

require_relative "dto_validator/version"
require_relative "utils"
require_relative "constants"
require_relative "errors"
require_relative "exceptions/validation_error"
require_relative "exceptions/unrecognized_parameter_error"

load_validators!

module DtoValidator
  class Error < StandardError; end
  
  class Base
    extend Utils
    
    attr_accessor :errors

    @@validations = {}
    @@custom_validations = {}
    @@transformers = {}
  
    def self.validates(*args)
      @@validations[self.name] = {} if !@@validations[self.name]
  
      _field, *params = args
      field = _field
  
      if field.end_with? '?'
        field = field[0..-2]
      end

      raise ValidationError.new(field) if @@validations[self.name][field]
  
      @@validations[self.name][field] = DEFAULT_FIELD_PAYLOAD.dup
  
      field_validations = @@validations[self.name][field]

      if _field.end_with? '?'
        field_validations[:required] = false
      end
  
      params.each do |param|
        if param.class == Symbol
          if !ALL_PARAMS.include? param
            raise UnrecognizedParameterError.new(key)
          end
          
          if ALL_TYPES.include? param
            validator_class = map_validator param
            field_validations[:type] = validator_class.new(field)
          end

          field_validations[:required] = true if param == :required
          field_validations[:required] = false if param == :optional

        elsif param.class == Hash
          param.each do |hash_key, hash_value|
            case hash_key
            when :required, :presence
              unless [TrueClass, FalseClass].include? hash_value.class
                raise "Wrong value type for #{hash_key} parameter"
              end

              field_validations[:required] = hash_value
            when :optional
              unless [TrueClass, FalseClass].include? hash_value.class
                raise "Wrong value type for #{hash_key} parameter"
              end

              field_validations[:required] = !hash_value
            else
              if ALL_TYPES.include? hash_key
                validator_class = map_validator hash_key
                validator = validator_class.new(field)

                hash_value.each do |validator_key, validator_value|
                  if validator.supports_validation? validator_key
                    validator.public_send("validate_#{validator_key}", field, validator_value)
                  end
                end
                
                field_validations[:type] = validator
              else
                raise "Unrecognized parameter #{hash_key}"
              end
            end
          end
        end
      end
    end
  
    def self.validate(custom_validator_name)
      @@custom_validations[self.name] = [] if @@custom_validations[self.name].nil?
      
      @@custom_validations[self.name] << custom_validator_name
    end

    def self.transforms(field_name, transformer)
      @@transformers[self.name] = {} if @@transformers[self.name].nil?
      @@transformers[self.name][field_name] = [] if @@transformers[self.name][field_name].nil?
      @@transformers[self.name][field_name] << transformer
    end

    def initialize(payload)
      @json = payload

      @json.each do |key, value|
        remember(key, value)
      end
    end
  
    def to_json
      serialized_json = {
        **@json,  
      }

      (@@transformers[self.class.name] || []).each do |field_name, transformers|
        transformers.each do |transformer_name|
          serialized_json[field_name] = self.public_send(transformer_name)
        end
      end

      serialized_json
    end

    def serialize
      to_json
    end
  
    def validate
      __validate__(raise_exception: false)
    end
    
    def validate!
      __validate__(raise_exception: true)
    end

    private
    def __validate__(raise_exception:)
      @errors = Errors.new

      (@@validations[self.class.name] || []).each do |field_name, model|
        value = @json[field_name]
        
        if model[:required] && value.nil?
          raise "'#{field_name}' is required"
        end

        if raise_exception
          model[:type].validate!(field_name, value)
        else
          err = model[:type].validate(field_name, value)

          errors << err if err
        end
      end

      # unless @@validations[self.class.name].nil?
      #   @@validations[self.class.name].each do |key, value|
      #     remember(key, @json[key])
      #   end
      # else
      #   @json.each do |key, value|
      #     remember(key, value)
      #   end
      # end

      (@@custom_validations[self.class.name] || []).each do |custom_validator_name|
        self.public_send(custom_validator_name)
      end
  
      return @errors.empty?, @errors.empty? ? nil : @errors
    end
  
    private
    def remember(variable, value)
      self.class.send(:define_method, "#{variable}=".to_sym) do |value|
        instance_variable_set("@" + variable.to_s, value)
      end
  
      self.class.send(:define_method, variable.to_sym) do
        instance_variable_get("@" + variable.to_s)
      end
  
      self.send("#{variable}=".to_sym, value)
    end
  end
end
