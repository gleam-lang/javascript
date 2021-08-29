import gleam/javascript/promise.{Promise}
import gleam/javascript.{ObjectType}

pub fn map_does_not_collapse_nested_promise_test() -> Promise(Promise(Int)) {
  promise.resolve(1)
  |> promise.map(promise.resolve)
  |> promise.tap(fn(value) {
    // If the `Promise(Promise(Int))` collapsed into `Promise(Int)` (as they
    // do for normal JS promises) then this would fail as the value would be the
    // int value `1`.
    assert ObjectType = javascript.type_of(value)
  })
}

pub fn then_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.then(fn(a) { promise.resolve(a + 1) })
  |> promise.tap(fn(a) { assert 2 = a })
}

pub fn then_does_collapse_nested_promise_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.then(promise.resolve)
  |> promise.tap(fn(value) { assert 1 = value })
}

pub fn map_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.map(fn(a) { a + 1 })
  |> promise.tap(fn(a) { assert 2 = a })
}

pub fn tap_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.tap(fn(a) { a + 1 })
  |> promise.tap(fn(a) { assert 1 = a })
}

pub fn map_try_ok_ok_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Ok(1))
  |> promise.map_try(fn(a) { Ok(a + 1) })
  |> promise.tap(fn(a) { assert Ok(2) = a })
}

pub fn map_try_ok_error_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Ok(1))
  |> promise.map_try(fn(a) { Error(a + 1) })
  |> promise.tap(fn(a) { assert Error(2) = a })
}

pub fn map_try_error_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Error(1))
  |> promise.map_try(fn(a) { Ok(a + 1) })
  |> promise.tap(fn(a) { assert Error(1) = a })
}

pub fn then_try_ok_ok_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Ok(1))
  |> promise.then_try(fn(a) { promise.resolve(Ok(a + 1)) })
  |> promise.tap(fn(a) { assert Ok(2) = a })
}

pub fn then_try_ok_error_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Ok(1))
  |> promise.then_try(fn(a) { promise.resolve(Error(a + 1)) })
  |> promise.tap(fn(a) { assert Error(2) = a })
}

pub fn then_try_error_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Error(1))
  |> promise.then_try(fn(a) { promise.resolve(Ok(a + 1)) })
  |> promise.tap(fn(a) { assert Error(1) = a })
}

pub fn rescue_healthy_test() {
  promise.resolve(1)
  |> promise.rescue(fn(_) { 100 })
  |> promise.tap(fn(a) { assert 1 = a })
}

pub fn rescue_poisoned_test() {
  promise.resolve(1)
  |> promise.map(fn(_) { assert 1 = 2 })
  |> promise.rescue(fn(_) { 100 })
  |> promise.tap(fn(a) { assert 100 = a })
}
