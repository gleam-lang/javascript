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
