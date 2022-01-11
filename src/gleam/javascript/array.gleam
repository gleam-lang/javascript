// TODO: docs
// TODO: labels
pub external type Array(element)

pub external fn to_list(Array(element)) -> List(element) =
  "../../gleam.mjs" "toList"

pub external fn from_list(List(element)) -> Array(element) =
  "../../ffi.mjs" "toArray"

pub external fn length(Array(element)) -> Int =
  "../../ffi.mjs" "length"

pub external fn map(Array(a), fn(a) -> b) -> Array(b) =
  "../../ffi.mjs" "map"

pub external fn fold(Array(e), a, fn(a, e) -> a) -> a =
  "../../ffi.mjs" "reduce"

pub external fn fold_right(Array(e), a, fn(a, e) -> a) -> a =
  "../../ffi.mjs" "reduceRight"

pub external fn get(Array(e), Int) -> Result(e, Nil) =
  "../../ffi.mjs" "index"
