import gleam/javascript.{
  BooleanType, FunctionType, NumberType, ObjectType, StringType, SymbolType,
  UndefinedType,
}

pub fn type_of_test() {
  let assert UndefinedType = javascript.type_of(Nil)
  let assert NumberType = javascript.type_of(1)
  let assert NumberType = javascript.type_of(1.1)
  let assert BooleanType = javascript.type_of(True)
  let assert BooleanType = javascript.type_of(False)
  let assert StringType = javascript.type_of("ok")
  let assert StringType = javascript.type_of("")
  let assert FunctionType = javascript.type_of(fn() { 1 })
  let assert FunctionType = javascript.type_of(fn(x) { x })
  let assert FunctionType = javascript.type_of(type_of_test)
  let assert FunctionType = javascript.type_of(Ok)
  let assert ObjectType = javascript.type_of(Ok(1))
  let assert ObjectType = javascript.type_of(Error("ok"))
  let assert SymbolType = javascript.type_of(javascript.get_symbol("Gleam"))
}

pub fn find_symbol_test() {
  let assert True =
    javascript.get_symbol("Gleam") == javascript.get_symbol("Gleam")
  let assert False =
    javascript.get_symbol("Gleam") == javascript.get_symbol("Lua")
}
