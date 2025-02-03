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

/// Determine what category of JavaScript type a value belongs to.
///
/// This uses the JavaScript `typeof` operator and has limited accuracy. It
/// cannot tell you anything about what Gleam type a value has.
///
/// For further information view the MDN documentation: 
/// <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol>
///
@external(javascript, "./gleam_javascript_test_ffi.mjs", "type_of")
pub fn type_of(a: value) -> TypeOf
