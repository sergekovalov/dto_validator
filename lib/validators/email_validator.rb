class EmailValidator < RegexValidator
  def initialize(field_name)
    super()

    validate_regex(field_name, URI::MailTo::EMAIL_REGEXP)
  end
end
