import gleam/result
import gleam/javascript/big_int
import gleeunit/should

pub fn create_test() {
  big_int.from_string("1")
  |> should.equal(Ok(big_int.from_int(1)))
}

pub fn invalid_number_test() {
  big_int.from_string("0abv")
  |> should.equal(Error(Nil))
}

pub fn add_test() {
  // a = 2 ^ 64
  use a <- result.then(big_int.from_string("18446744073709551616"))
  use b <- result.then(big_int.from_string("1"))

  use r <- result.then(big_int.from_string("18446744073709551617"))
  big_int.add(a, b)
  |> should.equal(r)
  Ok(Nil)
}

pub fn multiply_test() {
  // a = 2 ^ 64
  use a <- result.then(big_int.from_string("18446744073709551616"))
  use b <- result.then(big_int.from_string("10"))

  use r <- result.then(big_int.from_string("184467440737095516160"))
  big_int.multiply(a, b)
  |> should.equal(r)
  Ok(Nil)
}

pub fn subtract_test() {
  // a = 2 ^ 64 + 1
  use a <- result.then(big_int.from_string("18446744073709551617"))
  use b <- result.then(big_int.from_string("1"))

  use r <- result.then(big_int.from_string("18446744073709551616"))
  big_int.subtract(a, b)
  |> should.equal(r)
  Ok(Nil)
}

pub fn modulo_test() {
  // a = 2 ^ 64
  use a <- result.then(big_int.from_string("18446744073709551616"))
  use b <- result.then(big_int.from_string("2"))

  use r <- result.then(big_int.from_string("0"))
  big_int.modulo(a, b)
  |> should.equal(r)
  Ok(Nil)
}

pub fn power_test() {
  // a = 2 ^ 64
  use a <- result.then(big_int.from_string("18446744073709551616"))
  use b <- result.then(big_int.from_string("2"))

  use r <- result.then(big_int.from_string(
    "340282366920938463463374607431768211456",
  ))
  big_int.power(a, b)
  |> should.equal(r)
  Ok(Nil)
}

pub fn divide_test() {
  // a = 2 ^ 64
  use a <- result.then(big_int.from_string("18446744073709551616"))
  use b <- result.then(big_int.from_string("2"))

  use r <- result.then(big_int.from_string("9223372036854775808"))
  big_int.divide(a, b)
  |> should.equal(r)
  Ok(Nil)
}
