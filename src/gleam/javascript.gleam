/// Symbols are special unique values in JavaScript.
///
/// For further information view the MDN documentation: 
/// <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol>
///
pub type Symbol

/// Use the JavaScript `Symbol.for` method to look up a symbol with the given
/// string name, creating a new one if one does exist.
///
/// For further information see the MDN documentation:
/// <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol/for>
///
@external(javascript, "../gleam_javascript_ffi.mjs", "get_symbol")
pub fn get_symbol(a: String) -> Symbol
