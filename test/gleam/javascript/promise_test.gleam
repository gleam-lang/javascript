import gleam/javascript/array
import gleam/javascript/promise.{type Promise}
import helper.{ObjectType}

pub fn new_promise_test() {
  promise.new(fn(resolve) { resolve(1) })
  |> promise.tap(fn(value) {
    let assert 1 = value
  })
}

pub fn new_does_not_collapse_nested_promise_test() {
  promise.new(fn(resolve) { resolve(promise.new(fn(resolve) { resolve(1) })) })
  |> promise.tap(fn(value) {
    // If the `Promise(Promise(Int))` collapsed into `Promise(Int)` (as they
    // do for normal JS promises) then this would fail as the value would be the
    // int value `1`.
    let assert ObjectType = helper.type_of(value)
  })
}

pub fn start_promise_test() {
  let #(p, resolve) = promise.start()
  promise.tap(p, fn(value) {
    let assert 1 = value
  })
  resolve(1)
}

pub fn start_does_not_collapse_nested_promise_test() {
  let #(p, resolve) = promise.start()
  promise.tap(p, fn(value) {
    // If the `Promise(Promise(Int))` collapsed into `Promise(Int)` (as they
    // do for normal JS promises) then this would fail as the value would be the
    // int value `1`.
    let assert ObjectType = helper.type_of(value)
  })
  resolve(promise.resolve(1))
}

pub fn map_does_not_collapse_nested_promise_test() -> Promise(Promise(Int)) {
  promise.resolve(1)
  |> promise.map(promise.resolve)
  |> promise.tap(fn(value) {
    // If the `Promise(Promise(Int))` collapsed into `Promise(Int)` (as they
    // do for normal JS promises) then this would fail as the value would be the
    // int value `1`.
    let assert ObjectType = helper.type_of(value)
  })
}

pub fn await_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.await(fn(a) { promise.resolve(a + 1) })
  |> promise.tap(fn(a) {
    let assert 2 = a
  })
}

pub fn await_does_not_collapse_nested_promise_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.await(promise.resolve)
  |> promise.tap(fn(value) {
    let assert 1 = value
  })
}

pub fn map_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.map(fn(a) { a + 1 })
  |> promise.tap(fn(a) {
    let assert 2 = a
  })
}

pub fn tap_test() -> Promise(Int) {
  promise.resolve(1)
  |> promise.tap(fn(a) { a + 1 })
  |> promise.tap(fn(a) {
    let assert 1 = a
  })
}

pub fn map_try_ok_ok_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Ok(1))
  |> promise.map_try(fn(a) { Ok(a + 1) })
  |> promise.tap(fn(a) {
    let assert Ok(2) = a
  })
}

pub fn map_try_ok_error_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Ok(1))
  |> promise.map_try(fn(a) { Error(a + 1) })
  |> promise.tap(fn(a) {
    let assert Error(2) = a
  })
}

pub fn map_try_error_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Error(1))
  |> promise.map_try(fn(a) { Ok(a + 1) })
  |> promise.tap(fn(a) {
    let assert Error(1) = a
  })
}

pub fn try_await_ok_ok_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Ok(1))
  |> promise.try_await(fn(a) { promise.resolve(Ok(a + 1)) })
  |> promise.tap(fn(a) {
    let assert Ok(2) = a
  })
}

pub fn try_await_ok_error_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Ok(1))
  |> promise.try_await(fn(a) { promise.resolve(Error(a + 1)) })
  |> promise.tap(fn(a) {
    let assert Error(2) = a
  })
}

pub fn try_await_error_test() -> Promise(Result(Int, Int)) {
  promise.resolve(Error(1))
  |> promise.try_await(fn(a) { promise.resolve(Ok(a + 1)) })
  |> promise.tap(fn(a) {
    let assert Error(1) = a
  })
}

pub fn rescue_healthy_test() {
  promise.resolve(1)
  |> promise.rescue(fn(_) { 100 })
  |> promise.tap(fn(a) {
    let assert 1 = a
  })
}

pub fn rescue_poisoned_test() {
  promise.resolve(1)
  |> promise.map(fn(_) {
    let assert 1 = 2
  })
  |> promise.rescue(fn(_) { 100 })
  |> promise.tap(fn(a) {
    let assert 100 = a
  })
}

pub fn await_array_test() {
  promise.await_array(
    array.from_list([
      promise.resolve(1),
      promise.resolve(3),
      promise.resolve(4),
      promise.resolve(6),
      promise.resolve(10),
      promise.resolve(13),
    ]),
  )
  |> promise.tap(fn(x) {
    let assert [1, 3, 4, 6, 10, 13] = array.to_list(x)
  })
}

pub fn await_list_test() {
  promise.await_list([
    promise.resolve(1),
    promise.resolve(3),
    promise.resolve(4),
    promise.resolve(6),
    promise.resolve(10),
    promise.resolve(13),
  ])
  |> promise.tap(fn(x) {
    let assert [1, 3, 4, 6, 10, 13] = x
  })
}

fn never_resolving_promise() {
  promise.new(fn(_) { Nil })
}

pub fn race_list_test() {
  promise.race_list([
    never_resolving_promise(),
    promise.resolve(1),
    never_resolving_promise(),
  ])
  |> promise.tap(fn(x) {
    let assert 1 = x
  })
}

pub fn race_array_test() {
  promise.race_array(
    array.from_list([
      never_resolving_promise(),
      promise.resolve(1),
      never_resolving_promise(),
    ]),
  )
  |> promise.tap(fn(x) {
    let assert 1 = x
  })
}

pub fn promise_wait_test() {
  promise.tap(promise.wait(100), fn(x) {
    let Nil = x
  })
}
