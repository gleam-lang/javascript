// TODO: docs
// TODO: labels
pub external type Array(element)

pub external fn to_list(Array(element)) -> List(element) =
  "../../gleam.js" "toList"

pub external fn from_list(List(element)) -> Array(element) =
  "../../ffi.js" "toArray"

pub external fn length(Array(element)) -> Int =
  "../../ffi.js" "length"

pub external fn map(Array(a), fn(a) -> b) -> Array(b) =
  "../../ffi.js" "map"

pub external fn fold(Array(e), a, fn(a, e) -> a) -> a =
  "../../ffi.js" "reduce"

pub external fn fold_right(Array(e), a, fn(a, e) -> a) -> a =
  "../../ffi.js" "reduceRight"

pub external fn get(Array(e), Int) -> Result(e, Nil) =
  "../../ffi.js" "index"
