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
