# frozen_string_literal: true

RSpec.describe :number do
  class NumberDto < DtoValidator::Base
    validates :some_number, :number
  end

  it "validates number" do
    payload = {
      some_number: 6
    }
    
    dto = NumberDto.new payload
    res, errors = dto.validate
    
    expect(res).to eq(true)
    expect(res).to eq(true)
      expect(errors).to eq(nil)
  end
  
  it "throws error" do
    payload = {
      some_number: '18'
    }

    dto = NumberDto.new payload
    res, errors = dto.validate
    
    expect(res).to eq(false)
    expect(errors[0]).to eq("some_number is not valid number")
  end

  describe :min do
    class NumberMinDto < DtoValidator::Base
      validates :some_number_with_min_validation, number: { min: 5 }
    end

    it "validates number with minimal value" do
      payload = {
        some_number_with_min_validation: 6
      }
      
      dto = NumberMinDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_number_with_min_validation: 4
      }
      
      dto = NumberMinDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_number_with_min_validation cannot be less than 5")
    end
  end
  
  describe :max do
    class NumberMaxDto < DtoValidator::Base
      validates :some_number_with_max_validation, number: { max: 5 }
    end

    it "validates number with maximum value" do
      payload = {
        some_number_with_max_validation: 4
      }
      
      dto = NumberMaxDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_number_with_max_validation: 6
      }
      
      dto = NumberMaxDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_number_with_max_validation cannot be bigger than 5")
    end
  end
  
  describe :in do
    class NumberInDto < DtoValidator::Base
      validates :some_number_with_in_validation, number: { in: [1,2,3] }
    end

    it "validates number with value included in list" do
      payload = {
        some_number_with_in_validation: 2
      }
      
      dto = NumberInDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_number_with_in_validation: 4
      }
      
      dto = NumberInDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_number_with_in_validation is not included in [1, 2, 3]")
    end
  end
  
  describe :eq do
    class NumberEqDto < DtoValidator::Base
      validates :some_number_with_eq_validation, number: { eq: 2 }
    end

    it "validates number with value that equals to some value" do
      payload = {
        some_number_with_eq_validation: 2
      }
      
      dto = NumberEqDto.new payload
      res, errors = dto.validate

      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        some_number_with_eq_validation: 3
      }
      
      dto = NumberEqDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("some_number_with_eq_validation has to be equal to 2")
    end
  end
end