import gleam/javascript/big_int
import gleeunit/should

pub fn create_test() {
  1
  |> big_int.from_int()
  |> should.equal(big_int.from_string("1"))
}

pub fn add_test() {
  // a = 2 ^ 64
  let a = big_int.from_string("18446744073709551616")
  let b = big_int.from_string("1")

  big_int.add(a, b)
  |> should.equal(big_int.from_string("18446744073709551617"))
}
