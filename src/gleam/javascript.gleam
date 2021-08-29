// TODO: docs
pub type TypeOf {
  UndefinedType
  ObjectType
  BooleanType
  NumberType
  BigIntType
  StringType
  SymbolType
  FunctionType
}

pub external type Symbol

pub external fn type_of(value) -> TypeOf =
  "../ffi.js" "type_of"

pub external fn get_symbol(String) -> Symbol =
  "../ffi.js" "get_symbol"

pub external type Reference(value)

pub external fn dereference(Reference(a)) -> a =
  "../ffi.js" "dereference"

pub external fn set_reference(Reference(a), a) -> a =
  "../ffi.js" "set_reference"

pub external fn make_reference(a) -> Reference(a) =
  "../ffi.js" "make_reference"

// returns the old value
pub fn update_reference(ref: Reference(a), f: fn(a) -> a) -> a {
  let value = dereference(ref)
  set_reference(ref, f(value))
  value
}
