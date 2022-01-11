import gleam/dynamic.{Dynamic}
import gleam/javascript/array.{Array}

// TODO: docs
// TODO: labels
pub external type Promise(value)

pub external fn resolve(value) -> Promise(value) =
  "../../ffi.mjs" "resolve"

pub external fn rescue(Promise(value), fn(Dynamic) -> value) -> Promise(value) =
  "../../ffi.mjs" "rescue"

pub external fn then(Promise(a), fn(a) -> Promise(b)) -> Promise(b) =
  "../../ffi.mjs" "then"

pub external fn map(Promise(a), fn(a) -> b) -> Promise(b) =
  "../../ffi.mjs" "map_promise"

pub fn tap(promise: Promise(a), callback: fn(a) -> b) -> Promise(a) {
  promise
  |> map(fn(a) {
    callback(a)
    a
  })
}

pub fn map_try(
  promise: Promise(Result(a, e)),
  callback: fn(a) -> Result(b, e),
) -> Promise(Result(b, e)) {
  promise
  |> map(fn(result) {
    case result {
      Ok(a) -> callback(a)
      Error(e) -> Error(e)
    }
  })
}

pub fn then_try(
  promise: Promise(Result(a, e)),
  callback: fn(a) -> Promise(Result(b, e)),
) -> Promise(Result(b, e)) {
  promise
  |> then(fn(result) {
    case result {
      Ok(a) -> callback(a)
      Error(e) -> resolve(Error(e))
    }
  })
}

pub external fn await2(Promise(a), Promise(b)) -> Promise(#(a, b)) =
  "../../ffi.mjs" "all_promises"

pub external fn await3(
  Promise(a),
  Promise(b),
  Promise(c),
) -> Promise(#(a, b, c)) =
  "../../ffi.mjs" "all_promises"

pub external fn await4(
  Promise(a),
  Promise(b),
  Promise(c),
  Promise(d),
) -> Promise(#(a, b, c, d)) =
  "../../ffi.mjs" "all_promises"

pub external fn await5(
  Promise(a),
  Promise(b),
  Promise(c),
  Promise(d),
  Promise(e),
) -> Promise(#(a, b, c, d, e)) =
  "../../ffi.mjs" "all_promises"

pub external fn await6(
  Promise(a),
  Promise(b),
  Promise(c),
  Promise(d),
  Promise(e),
  Promise(f),
) -> Promise(#(a, b, c, d, e, f)) =
  "../../ffi.mjs" "all_promises"

pub external fn await_array(Array(Promise(a))) -> Promise(Array(a)) =
  "../../ffi.mjs" "all_promises"

pub fn await_list(xs: List(Promise(a))) -> Promise(List(a)) {
  xs
  |> do_await_list
  |> map(array.to_list)
}

pub external fn do_await_list(List(Promise(a))) -> Promise(Array(a)) =
  "../../ffi.mjs" "all_promises"
