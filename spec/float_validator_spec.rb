# frozen_string_literal: true

RSpec.describe :float do
  class FloatDto < DtoValidator::Base
    validates :some_float, :float
  end

  it "validates float" do
    payload = {
      some_float: 18.12
    }

    dto = FloatDto.new payload
    res, errors = dto.validate

    expect(res).to eq(true)
    expect(res).to eq(true)
      expect(errors).to eq(nil)
  end
  
  it "throws error" do
    payload = {
      some_float: 18
    }
    
    dto = FloatDto.new payload
    res, errors = dto.validate
    
    expect(res).to eq(false)
    expect(errors[0]).to eq("some_float is not valid float")
  end
end
