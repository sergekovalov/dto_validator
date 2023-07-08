# frozen_string_literal: true

RSpec.describe :bool do
  class BoolDto < DtoValidator::Base
    validates :some_bool, :bool
  end

  it "validates bool" do
    payload = {
      some_bool: true
    }

    dto = BoolDto.new payload
    res, errors = dto.validate

    expect(res).to eq(true)
    expect(res).to eq(true)
      expect(errors).to eq(nil)
  end
  
  it "throws error" do
    payload = {
      some_bool: 'test'
    }
    
    dto = BoolDto.new payload
    res, errors = dto.validate
    
    expect(res).to eq(false)
    expect(errors[0]).to eq("some_bool is not valid boolean")
  end
end