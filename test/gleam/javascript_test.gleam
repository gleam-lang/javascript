import gleam/javascript.{
  BooleanType, FunctionType, NumberType, ObjectType, StringType, SymbolType, UndefinedType,
}

pub fn type_of_test() {
  assert UndefinedType = javascript.type_of(Nil)
  assert NumberType = javascript.type_of(1)
  assert NumberType = javascript.type_of(1.1)
  assert BooleanType = javascript.type_of(True)
  assert BooleanType = javascript.type_of(False)
  assert StringType = javascript.type_of("ok")
  assert StringType = javascript.type_of("")
  assert FunctionType = javascript.type_of(fn() { 1 })
  assert FunctionType = javascript.type_of(fn(x) { x })
  assert FunctionType = javascript.type_of(type_of_test)
  assert FunctionType = javascript.type_of(Ok)
  assert ObjectType = javascript.type_of(Ok(1))
  assert ObjectType = javascript.type_of(Error("ok"))
  assert SymbolType = javascript.type_of(javascript.get_symbol("Gleam"))
}

pub fn find_symbol_test() {
  assert True = javascript.get_symbol("Gleam") == javascript.get_symbol("Gleam")
  assert False = javascript.get_symbol("Gleam") == javascript.get_symbol("Lua")
}
