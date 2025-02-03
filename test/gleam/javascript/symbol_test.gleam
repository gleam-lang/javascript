import gleam/javascript/symbol
import gleeunit/should

pub fn new_test() {
  let name = "same name"

  symbol.new(name)
  |> should.not_equal(symbol.new(name))
}

pub fn get_or_create_global_test() {
  let name = "same name"

  symbol.get_or_create_global(name)
  |> should.equal(symbol.get_or_create_global(name))

  symbol.get_or_create_global(name)
  |> should.not_equal(symbol.new(name))
}

pub fn description_test() {
  symbol.new("wibble")
  |> symbol.description
  |> should.equal(Ok("wibble"))
}
