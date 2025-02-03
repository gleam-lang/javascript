import {
  UndefinedType,
  ObjectType,
  BooleanType,
  NumberType,
  BigIntType,
  StringType,
  SymbolType,
  FunctionType,
} from "./helper.mjs";

export function type_of(value) {
  switch (typeof value) {
    case "undefined":
      return new UndefinedType();
    case "object":
      return new ObjectType();
    case "boolean":
      return new BooleanType();
    case "number":
      return new NumberType();
    case "bigint":
      return new BigIntType();
    case "string":
      return new StringType();
    case "symbol":
      return new SymbolType();
    case "function":
      return new FunctionType();
    default:
      throw new globalThis.Error(`Unexpected typeof ${typeof value}`);
  }
}
