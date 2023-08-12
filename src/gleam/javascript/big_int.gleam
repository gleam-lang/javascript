pub type BigInt

/// `+` operation
@external(javascript, "../../ffi.mjs", "add")
pub fn add(a: BigInt, b: BigInt) -> BigInt

/// `*` operation
@external(javascript, "../../ffi.mjs", "multiply")
pub fn multiply(a: BigInt, b: BigInt) -> BigInt

/// `-` operation
@external(javascript, "../../ffi.mjs", "subtract")
pub fn subtract(a: BigInt, b: BigInt) -> BigInt

/// `%` operation
@external(javascript, "../../ffi.mjs", "modulo")
pub fn modulo(a: BigInt, b: BigInt) -> BigInt

/// `**` operation
@external(javascript, "../../ffi.mjs", "power")
pub fn power(a: BigInt, b: BigInt) -> BigInt

/// `/` operation
@external(javascript, "../../ffi.mjs", "divide")
pub fn divide(a: BigInt, b: BigInt) -> BigInt

@external(javascript, "../../ffi.mjs", "from")
pub fn from_int(a: Int) -> BigInt

@external(javascript, "../../ffi.mjs", "from")
pub fn from_string(a: String) -> BigInt
