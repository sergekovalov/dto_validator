# frozen_string_literal: true

RSpec.describe :integer do
  class IntegerDto < DtoValidator::Base
    validates :some_integer, :integer
  end

  it "validates integer" do
    payload = {
      some_integer: 18
    }

    dto = IntegerDto.new payload
    res, errors = dto.validate

    expect(res).to eq(true)
    expect(res).to eq(true)
      expect(errors).to eq(nil)
  end
  
  it "throws error" do
    payload = {
      some_integer: 18.12
    }
    
    dto = IntegerDto.new payload
    res, errors = dto.validate
    
    expect(res).to eq(false)
    expect(errors[0]).to eq("some_integer is not valid integer")
  end
end