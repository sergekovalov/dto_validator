# frozen_string_literal: true

RSpec.describe 'json/hash' do
  class SomeDto < DtoValidator::Base
    validates :some_number, :number
  end

  class JsonDto < DtoValidator::Base
    validates :some_json, :json
    validates :some_dto, json: { dto: SomeDto }
  end

  it "validates json/hash" do
    payload = {
      some_json: { foo: 'bar' },
      some_dto: {
        some_number: 6
      }
    }

    dto = JsonDto.new payload
    res, errors = dto.validate

    expect(res).to eq(true)
    expect(res).to eq(true)
      expect(errors).to eq(nil)
  end
  
  it "throws error" do
    payload = {
      some_json: 'not_json',
      some_dto: {
        some_number: 'some_string'
      }
    }
    
    dto = JsonDto.new payload
    res, errors = dto.validate
    
    expect(res).to eq(false)
    expect(errors.length).to eq(2)
    expect(errors[0]).to eq("some_json is not valid JSON/Hash")
    expect(errors[1]).to eq("some_dto validation did not pass")
  end
end