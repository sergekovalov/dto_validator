# DtoValidator

# About

Validator for your DTOs

# Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add dto_validator

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install dto_validator

# Usage
## Simple sample

```ruby
require 'dto_validator'

class ExampleDto < DtoValidator::Base
    validates :some_number,  number:    { in: [1,2,3] }
    validates :some_float,   float:     { eq: 3.14 }
    validates :some_integer, integer:   { between: [1,10] }
    validates :some_string,  string:    { min_length: 2 }
    validates :some_array,   array:     { of: [:integer, :bool] }
    validates :some_email,   :email
    validates :password,     :any
end

dto = ExampleDto.new some_json # json or hash, e.g. Rails params object

dto.validate!

# or

res, error = dto.validate
```

## Validators
### Number
Valildates a number (integer or float)
Supports following validations:
- eq: <SOME_NUMBER>
- in: <SOME_ARRAY>
- min: <SOME_NUMBER>
- max: <SOME_NUMBER>
- between: [<SOME_NUMBER>, <SOME_NUMBER>]

```ruby
class ExampleDto < DtoValidator::Base
    validates :some_number_with_eq_validation,      number: { eq: 3.14 }
    validates :some_number_with_in_validation,      number: { in: [1,2,3] }
    validates :some_number_with_min_validation,     number: { min: -1000 }
    validates :some_number_with_max_validation,     number: { max: 10 }
    validates :some_number_with_between_validation, number: { between: [-1,1] }
end
```

### Integer
Valildates an integer
Supports following validations:
- all the Number validations

```ruby
class ExampleDto < DtoValidator::Base
    validates :some_integer, :integer
end
```

### Float
Valildates a float
Supports following validations:
- all the Number validations

```ruby
class ExampleDto < DtoValidator::Base
    validates :some_float, :float
end
```

### String
Valildates a string
Supports following validations:
- eq: <SOME_VALUE>
- in: <SOME_ARRAY>
- length: <SOME_NUMBER>
- min_length: <SOME_NUMBER>
- max_length: <SOME_NUMBER>
- regex: <SOME_REGEXP>

```ruby
class ExampleDto < DtoValidator::Base
    validates :some_string_with_eq_validation,          string: { eq: 'some_value' }
    validates :some_string_with_in_validation,          string: { in: ['1','2','3'] }
    validates :some_string_with_length_validation,      string: { length: 10 }
    validates :some_string_with_min_length_validation,  string: { min_length: -100 }
    validates :some_string_with_max_length_validation,  string: { max_length: 100 }
    validates :some_string_with_regexp_validation,      string: { regex: URI::MailTo::EMAIL_REGEXP }
end
```

### Email
Valildates a string which represents a valid email

```ruby
class ExampleDto < DtoValidator::Base
    validates :some_email, :email
end
```


### Array
Valildates an array
Supports following validations:
- of: <SOME_TYPE> or [<SOME_TYPE>]
- eq: <SOME_VALUE>
- in: <SOME_ARRAY>
- length: <SOME_NUMBER>
- min_length: <SOME_NUMBER>
- max_length: <SOME_NUMBER>

```ruby
class ExampleDto < DtoValidator::Base
    validates :some_array,                              :array
    validates :some_array_with_of_validation,           array: { of: :integer }
    validates :some_array_with_eq_validation,           array: { eq: [1,2] }
    validates :some_array_with_in_validation,           array: { in: [1,2,3] }
    validates :some_array_with_length_validation,       array: { length: 10 }
    validates :some_array_with_min_length_validation,   array: { min_length: 1 }
    validates :some_array_with_max_length_validation,   array: { max_length: 10 }
end
```

## Transformers



# Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sergekovalov/dto_validator.

# License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
