/// The variants that `type_of` can return.
pub type TypeOf {
  /// It is the value `undefined`.
  UndefinedType
  /// It is some object, or it is `null`.
  ObjectType
  /// It is either `true` or `false`.
  BooleanType
  /// It is some number, a 64 bit float.
  NumberType
  /// It is a JavaScript big-integer.
  BigIntType
  /// It is a string.
  StringType
  /// It is a JavaScript symbol.
  SymbolType
  /// It is a function of unknown argument types and return type.
  FunctionType
}

/// Symbols are special unique values in JavaScript.
///
/// For further information view the MDN documentation: 
/// <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol>
///
pub type Symbol

/// Determine what category of JavaScript type a value belongs to.
///
/// This uses the JavaScript `typeof` operator and has limited accuracy. It
/// cannot tell you anything about what Gleam type a value has.
///
/// For further information view the MDN documentation: 
/// <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol>
///
@external(javascript, "../gleam_javascript_ffi.mjs", "type_of")
pub fn type_of(a: value) -> TypeOf

/// Use the JavaScript `Symbol.for` method to look up a symbol with the given
/// string name, creating a new one if one does exist.
///
/// For further information see the MDN documentation:
/// <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol/for>
///
@external(javascript, "../gleam_javascript_ffi.mjs", "get_symbol")
pub fn get_symbol(a: String) -> Symbol

@deprecated("The Reference type is being removed from this packge")
pub type Reference(value)

@deprecated("The Reference type is being removed from this packge")
@external(javascript, "../gleam_javascript_ffi.mjs", "dereference")
pub fn dereference(a: Reference(a)) -> a

@deprecated("The Reference type is being removed from this packge")
@external(javascript, "../gleam_javascript_ffi.mjs", "set_reference")
pub fn set_reference(a: Reference(a), b: a) -> a

@deprecated("The Reference type is being removed from this packge")
@external(javascript, "../gleam_javascript_ffi.mjs", "make_reference")
pub fn make_reference(a: a) -> Reference(a)

@deprecated("The Reference type is being removed from this packge")
pub fn update_reference(ref: Reference(a), f: fn(a) -> a) -> a {
  let value = dereference(ref)
  set_reference(ref, f(value))
  value
}

@deprecated("The Reference type is being removed from this packge")
@external(javascript, "../gleam_javascript_ffi.mjs", "reference_equal")
pub fn reference_equal(a: Reference(a), b: Reference(a)) -> Bool
