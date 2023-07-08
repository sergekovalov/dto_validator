# frozen_string_literal: true

RSpec.describe :default do
  describe 'simple sample' do
    class SimpleSampleDto < DtoValidator::Base
      validates :some_number, number: { in: [1,2,3] }
      validates :some_string, string: { min_length: 10 }
      validates :some_email, :email
    end

    it "validates simple sample" do
      payload = {
        some_number: 1,
        some_string: '_' * 10,
        some_email: 'test@example.com'
      }
      
      dto = SimpleSampleDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_number: '1',
        some_string: '_',
        some_email: 'wrong_email'
      }

      dto = SimpleSampleDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors.length).to eq(3)
      expect(errors[0]).to eq("some_number is not valid number")
    end
  end

  describe 'custom validation' do
    class CustomValidatorDto < DtoValidator::Base
      validate :custom_validator

      def custom_validator
        errors.add("some_string is not valid string") unless some_string.class == String
      end
    end

    it "validates custom validator" do
      payload = {
        some_string: 'test',
      }
      
      dto = CustomValidatorDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end

    it "throws error" do
      payload = {
        some_string: 123,
      }

      dto = CustomValidatorDto.new payload
      res, errors = dto.validate

      expect(errors[0]).to eq("some_string is not valid string")
    end
  end

  describe :transformers do
    class TransformerDto < DtoValidator::Base
      validates :some_string, :string

      transforms :some_string, :custom_transformer

      def custom_transformer
        some_string.upcase
      end
    end

    it "validates transformer" do
      payload = {
        some_string: 'test',
      }
      
      dto = TransformerDto.new payload
      serialized = dto.to_json

      expect(serialized[:some_string]).to eq(payload[:some_string].upcase)
    end
  end
end