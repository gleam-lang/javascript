import { Ok, Error } from "./gleam.js";
import {
  UndefinedType,
  ObjectType,
  BooleanType,
  NumberType,
  BigIntType,
  StringType,
  SymbolType,
  FunctionType,
} from "./gleam/javascript.js";

export function toArray(list) {
  return list.toArray();
}

export function map(thing, fn) {
  return thing.map(fn);
}

export function length(thing) {
  return thing.length;
}

export function reduce(thing, acc, fn) {
  return thing.reduce(fn, acc);
}

export function reduceRight(thing, acc, fn) {
  return thing.reduceRight(fn, acc);
}

export function index(thing, index) {
  return index in thing ? new Ok(thing[index]) : new Error(undefined);
}

export function object_from_entries(entries) {
  return Object.fromEntries(entries);
}

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

export function get_symbol(name) {
  return Symbol.for(name);
}
