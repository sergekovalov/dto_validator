# frozen_string_literal: true

RSpec.describe :string do
  class StringDto < DtoValidator::Base
    validates :some_string, :string
  end

  it "validates string" do
    payload = {
      some_string: '123'
    }

    dto = StringDto.new payload
    res, errors = dto.validate

    expect(res).to eq(true)
    expect(res).to eq(true)
      expect(errors).to eq(nil)
  end
  
  it "throws error" do
    payload = {
      some_string: 123
    }
    
    dto = StringDto.new payload
    res, errors = dto.validate
    
    expect(res).to eq(false)
    expect(errors[0]).to eq("some_string is not valid string")
  end

  describe :min_length do
    class StringMinLengthDto < DtoValidator::Base
      validates :some_str_with_min_length_validation, string: { min_length: 5 }
    end

    it "validates number with minimal length" do
      payload = {
        some_str_with_min_length_validation: '12345'
      }
      
      dto = StringMinLengthDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_str_with_min_length_validation: '1234'
      }
      
      dto = StringMinLengthDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_str_with_min_length_validation length cannot be less than 5")
    end
  end
  
  describe :max_length do
    class StringMaxLengthDto < DtoValidator::Base
      validates :some_str_with_max_length_validation, string: { max_length: 5 }
    end

    it "validates number with maximum length" do
      payload = {
        some_str_with_max_length_validation: '12345'
      }
      
      dto = StringMaxLengthDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_str_with_max_length_validation: '123456'
      }
      
      dto = StringMaxLengthDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_str_with_max_length_validation length cannot be greater than 5")
    end
  end
  
  describe :length do
    class StringLengthDto < DtoValidator::Base
      validates :some_str_with_length_validation, string: { length: 5 }
    end

    it "validates number with exact length" do
      payload = {
        some_str_with_length_validation: '12345'
      }
      
      dto = StringLengthDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_str_with_length_validation: '123'
      }
      
      dto = StringLengthDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_str_with_length_validation has to have a length = 5")
    end
  end
  
  describe :not_empty do
    class StringNotEmptyDto < DtoValidator::Base
      validates :some_str_with_not_empty_validation, string: { not_empty: true }
    end

    it "validates not empty string" do
      payload = {
        some_str_with_not_empty_validation: 'some value'
      }
      
      dto = StringNotEmptyDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_str_with_not_empty_validation: ''
      }
      
      dto = StringNotEmptyDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_str_with_not_empty_validation should not be empty")
    end
  end

  describe :not_empty_strip do
    class StringNotEmptyStripDto < DtoValidator::Base
      validates :some_str_with_not_empty_strip_validation, string: { not_empty_strip: true }
    end

    it "validates not empty string" do
      payload = {
        some_str_with_not_empty_strip_validation: 'some value'
      }
      
      dto = StringNotEmptyStripDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_str_with_not_empty_strip_validation: ' '
      }
      
      dto = StringNotEmptyStripDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_str_with_not_empty_strip_validation should not be empty")
    end
  end
end