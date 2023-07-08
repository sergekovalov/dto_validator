NUMBER_TYPES = [:number, :integer, :float]
ALL_TYPES = [*NUMBER_TYPES, :any, :string, :regex, :email, :bool, :json, :array, :array_of, :hash, :json]
ALL_PARAMS = [*ALL_TYPES, :required, :presence, :optional]

DEFAULT_FIELD_PAYLOAD = {
  type: :any,
  required: true,
}

ERROR_MESSAGES = {
    
}