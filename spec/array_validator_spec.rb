# frozen_string_literal: true

RSpec.describe :array do
  describe 'array of :any' do
    class ArrayOfAnyDto < DtoValidator::Base
      validates :array_of_any, :array
    end

    it "validates array of any" do
      payload = {
        array_of_any: [1,2,3]
      }
  
      dto = ArrayOfAnyDto.new payload
      res, errors = dto.validate
  
      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        array_of_any: '[1, 2, 3]'
      }
      
      dto = ArrayOfAnyDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("array_of_any is not valid array")
    end
  end
  
  describe 'array of integers' do
    class ArrayOfIntegerDto < DtoValidator::Base
      validates :array_of_int, array: { of: :integer }
    end

    it "validates array of integers" do
      payload = {
        array_of_int: [1,2,3]
      }
  
      dto = ArrayOfIntegerDto.new payload
      res, errors = dto.validate
  
      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        array_of_int: ['1', '2', '3']
      }
      
      dto = ArrayOfIntegerDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("array_of_int has to be of type [Integer]")
    end
  end
  
  describe 'array of integers and strings' do
    class ArrayOfStringDto < DtoValidator::Base
      validates :array_of_int_and_string, array: { of: [:integer, :string] }
    end

    it "validates array of integers and strings" do
      payload = {
        array_of_int_and_string: [1,2,3]
      }
  
      dto = ArrayOfStringDto.new payload
      res, errors = dto.validate
  
      expect(res).to eq(true)
      expect(errors).to eq(nil)
    end
    
    it "throws error" do
      payload = {
        array_of_int_and_string: ['1', 2, true]
      }
      
      dto = ArrayOfStringDto.new payload
      res, errors = dto.validate
      
      expect(res).to eq(false)
      expect(errors[0]).to eq("array_of_int_and_string has to be of type [Integer, String]")
    end
  end
end