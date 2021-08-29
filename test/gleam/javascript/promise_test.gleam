import gleam/javascript/promise.{Promise}
import gleam/javascript.{ObjectType}

pub fn map_does_not_collapse_nested_promise_test() -> Promise(Promise(Int)) {
  promise.resolve(1)
  |> promise.map(promise.resolve)
  |> promise.map(fn(value) {
    // If the `Promise(Promise(Int))` collapsed into `Promise(Int)` (as they
    // do for normal JS promises) then this would fail as the value would be the
    // int value `1`.
    assert ObjectType = javascript.type_of(value)
    value
  })
}

pub fn then_does_collapse_nested_promise_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.then(promise.resolve)
  |> promise.map(fn(value) { assert 1 = value })
}
