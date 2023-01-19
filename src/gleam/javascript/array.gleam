/// A JavaScript array, in Gleam!
///
/// Unlike most data structures in Gleam this one is mutable.
///
pub external type Array(element)

/// Convert a JavaScript array to a Gleam list.
///
/// Runs in linear time.
///
pub external fn to_list(Array(element)) -> List(element) =
  "../../gleam.mjs" "toList"

/// Convert a Gleam list to a JavaScript array.
///
/// Runs in linear time.
///
pub external fn from_list(List(element)) -> Array(element) =
  "../../ffi.mjs" "toArray"

/// Get the number of elements in the array.
///
/// Runs in constant time.
///
pub external fn size(Array(element)) -> Int =
  "../../ffi.mjs" "length"

/// Returns a new array containing only the elements of the first array after
/// the function has been applied to each one.
///
/// Runs in linear time.
///
/// # Examples
///
/// ```gleam
/// > map(from_list([2, 4, 6]), fn(x) { x * 2 })
/// from_list([4, 8, 12])
/// ```
///
pub external fn map(Array(a), with: fn(a) -> b) -> Array(b) =
  "../../ffi.mjs" "map"

/// Reduces a list of elements into a single value by calling a given function
/// on each element, going from left to right.
///
/// `fold(from_list([1, 2, 3]), 0, add)` is the equivalent of
/// `add(add(add(0, 1), 2), 3)`.
///
/// Runs in linear time.
///
pub external fn fold(over: Array(e), from: a, with: fn(a, e) -> a) -> a =
  "../../ffi.mjs" "reduce"

/// Reduces a list of elements into a single value by calling a given function
/// on each element, going from right to left.
///
/// `fold_right(from_list([1, 2, 3]), 0, add)` is the equivalent of
/// `add(add(add(0, 3), 2), 1)`.
///
/// Runs in linear time.
///
pub external fn fold_right(over: Array(e), from: a, with: fn(a, e) -> a) -> a =
  "../../ffi.mjs" "reduceRight"

/// Get the element at the given index.
///
/// # Examples
///
/// ```gleam
/// > get(from_list([2, 4, 6]), 1)
/// Ok(4)
/// ```
///
/// ```gleam
/// > get(from_list([2, 4, 6]), 4)
/// Error(Nil)
/// ```
///
pub external fn get(Array(e), Int) -> Result(e, Nil) =
  "../../ffi.mjs" "index"
