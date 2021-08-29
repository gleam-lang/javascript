pub external type Array(element)

pub external fn to_list(Array(element)) -> List(element) =
  "../../gleam.js" "toList"

pub external fn from_list(List(element)) -> Array(element) =
  "../../ffi.js" "toArray"

pub external fn length(Array(element)) -> Int =
  "../../ffi.js" "length"
