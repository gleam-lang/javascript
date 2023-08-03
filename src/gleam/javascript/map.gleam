pub type MutableMap(key, value)

@external(javascript, "../../ffi.mjs", "map_new")
pub fn new() -> MutableMap(key, value)

@external(javascript, "../../ffi.mjs", "map_set")
pub fn set(
  a: MutableMap(key, value),
  b: key,
  c: value,
) -> MutableMap(key, value)

@external(javascript, "../../ffi.mjs", "map_get")
pub fn get(a: MutableMap(key, value), b: key) -> Result(value, Nil)

@external(javascript, "../../ffi.mjs", "map_size")
pub fn size(a: MutableMap(key, value)) -> Int
