# Changelog

## v0.6.1 - 2023-09-08

- Republished to resolve an error in the package release which caused some
  modules to be missing from documentation.

## v0.6.0 - 2023-08-12

- Add `map` module native JavaScript maps.
- `promise.new` is added to enable creating promises with a delayed resolve.

## v0.5.0 - 2023-01-19

- Updated for Gleam v0.30.0.

## v0.4.0 - 2023-01-19

- `array.length` was renamed to `array.size` to match Gleam conventions of size
  being used when the operation is constant time.

## v0.3.0 - 2022-12-10

- The `then` and `then_try` function in the `promise` module have been renamed
  to `await` and `try_await`.
## v0.2.0 - 2022-11-22

- The `promise.do_await_list` function has been removed.

## v0.1.0 - 2022-01-11

- The `javascript` module was created with the `TypeOf`, and `Symbol` types, and
  `find_symbol`, `make_reference`, `set_reference`, `update_reference`,
  `dereference`, and `type_of` functions.
- The `javascript/array` module was created with the `Array(element)` type and
  `to_list`, `from_list`, `map`, `fold`, `fold_right`, `get`, and `length`
  functions.
- The `javascript/promise` module was created with the `Promise(value)` type and
  `rescue`, `resolve`, `tap`, `map_try`, `map`, `then_try`, `await{2,6}`,
  `await_list`, `await_array`, and `then` functions.
