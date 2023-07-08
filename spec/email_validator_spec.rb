# frozen_string_literal: true

RSpec.describe :email do
  class EmailDto < DtoValidator::Base
    validates :some_email, :email
  end

  it "validates email" do
    payload = {
      some_email: 'test@example.com'
    }

    dto = EmailDto.new payload
    res, errors = dto.validate

    expect(res).to eq(true)
    expect(res).to eq(true)
      expect(errors).to eq(nil)
  end
  
  it "throws error" do
    payload = {
      some_email: 'wrong_email'
    }
    
    dto = EmailDto.new payload
    res, errors = dto.validate
    
    expect(res).to eq(false)
    expect(errors[0]).to eq("some_email does not match")
  end
end
