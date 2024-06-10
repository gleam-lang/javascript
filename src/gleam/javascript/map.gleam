/// The JavaScript `Map` type, a **mutable** collection of keys and values.
///
/// Most the time you should use the `Dict` type from `gleam/dict` in the Gleam
/// standard library. This type may still be useful for JavaScript interop.
///
/// For further information view the MDN documentation: 
/// <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map>
///
pub type Map(key, value)

/// Create a new `Map` with no contained values.
///
@external(javascript, "../../gleam_javascript_ffi.mjs", "map_new")
pub fn new() -> Map(key, value)

/// Insert a new key and value into the `Map`.
///
/// **NOTE:** This function will mutate the `Map` rather than immutably
/// updating it.
///
@external(javascript, "../../gleam_javascript_ffi.mjs", "map_set")
pub fn set(a: Map(key, value), b: key, c: value) -> Map(key, value)

/// Get the value for a given key in the `Map`.
///
@external(javascript, "../../gleam_javascript_ffi.mjs", "map_get")
pub fn get(a: Map(key, value), b: key) -> Result(value, Nil)

/// Get the number of key-value pairs in the `Map`.
///
@external(javascript, "../../gleam_javascript_ffi.mjs", "map_size")
pub fn size(a: Map(key, value)) -> Int
