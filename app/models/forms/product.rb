class Forms::Product < Product
  REGISTRABLE_ATTRIBUTES = %i(register code name price)
  attr_accessor :register
end