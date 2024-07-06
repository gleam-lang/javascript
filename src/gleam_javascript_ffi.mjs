import { Ok, Error } from "./gleam.mjs";
import {
  UndefinedType,
  ObjectType,
  BooleanType,
  NumberType,
  BigIntType,
  StringType,
  SymbolType,
  FunctionType,
} from "./gleam/javascript.mjs";

/**
 * @param {{toArray(): any[]}} list
 */
export function toArray(list) {
  return list.toArray();
}

/**
 * @template A, B
 * @param {A[]} thing
 * @param {function(A): B} fn
 */
export function map(thing, fn) {
  return thing.map(fn);
}

/**
 * @param {any[]} thing
 */
export function length(thing) {
  return thing.length;
}

/**
 * @template A, E
 * @param {E[]} thing
 * @param {A} acc
 * @param {function(A,E): A} fn
 */
export function reduce(thing, acc, fn) {
  return thing.reduce(fn, acc);
}

/**
 * @template A, E
 * @param {E[]} thing
 * @param {A} acc
 * @param {function(A,E): A} fn
 */
export function reduceRight(thing, acc, fn) {
  return thing.reduceRight(fn, acc);
}

/**
 * @template E
 * @param {E[]} thing - A JS array
 * @param {number} index
 * @returns {Ok<E,undefined> | Error<E,undefined>}
 */
export function index(thing, index) {
  return index in thing ? new Ok(thing[index]) : new Error(undefined);
}

/**
 * @param {Iterable<readonly any[]>} entries - An iterable of key-value pairs
 */
export function object_from_entries(entries) {
  return Object.fromEntries(entries);
}

/**
 * 
 * @param {any} value 
 * @returns {UndefinedType | ObjectType | BooleanType | NumberType 
 *           | BigIntType | StringType | SymbolType | FunctionType}
 */
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

/**
 * @param {string} name 
 */
export function get_symbol(name) {
  return Symbol.for(name);
}

/**
 * A wrapper around a promise to prevent `Promise<Promise<T>>` collapsing into
 * `Promise<T>`.
 * 
 * @template T
 */
class PromiseLayer {
  /**
   * 
   * @param {Promise<T>} promise 
   */
  constructor(promise) {
    /** @type {Promise<T>} */
    this.promise = promise;
  }

  /**
   * @template U
   * @overload
   * @param {Promise<U>} value 
   * @returns {PromiseLayer<U>}
   */
  /**
   * @template U
   * @overload
   * @param {U} value 
   * @returns {U}
   */
  /**
   * @template U
   * @param {U | Promise<U>} value 
   * @returns {U | PromiseLayer<U>}
   */
  static wrap(value) {
    return value instanceof Promise ? new PromiseLayer(value) : value;
  }

  /**
   * @template U
   * @overload
   * @param {U} value
   * @returns {U}
   */
  /**
   * @template U
   * @overload
   * @param {PromiseLayer<U>} value
   * @returns {Promise<U>}
   */
  /**
   * @template U
   * @param {U | PromiseLayer<U>} value
   * @returns {U | Promise<U>}
   */
  static unwrap(value) {
    return value instanceof PromiseLayer ? value.promise : value;
  }
}

/**
 * @template T
 * @param {function((value: T) => void): void} executor
 * @returns {Promise<T | PromiseLayer<T>>}
 */
export function newPromise(executor) {
  return new Promise((resolve) =>
    executor((value) => {
      resolve(PromiseLayer.wrap(value));
    })
  );
}

/**
 * @template T
 * @param {T} value
 */
export function resolve(value) {
  return Promise.resolve(PromiseLayer.wrap(value));
}

/**
 * @template A, B
 * @param {Promise<A>} promise 
 * @param {function(A): Promise<B>} fn 
 */
export function then_await(promise, fn) {
  return promise.then((value) => fn(PromiseLayer.unwrap(value)));
}

/**
 * @template A, B
 * @param {Promise<A>} promise 
 * @param {function(A): B} fn 
 */
export function map_promise(promise, fn) {
  return promise.then((value) =>
    PromiseLayer.wrap(fn(PromiseLayer.unwrap(value)))
  );
}

/**
 * @template A
 * @param {Promise<A>} promise 
 * @param {function(any): A} fn 
 */
export function rescue(promise, fn) {
  return promise.catch((error) => fn(error));
}

/** @deprecated The Reference type is being removed from this package */
class Reference {
  constructor(value) {
    this.value = value;
  }
}

/** @deprecated The Reference type is being removed from this package */
export function dereference(reference) {
  return reference.value;
}

/** @deprecated The Reference type is being removed from this package */
export function make_reference(value) {
  return new Reference(value);
}

/** @deprecated The Reference type is being removed from this package */
export function set_reference(ref, value) {
  let previous = ref.value;
  ref.value = value;
  return previous;
}

/** @deprecated The Reference type is being removed from this package */
export function reference_equal(a, b) {
  return a === b
}

/**
 * A type guard to check if an array has exactly 1 element.
 * 
 * @template T
 * @param {[T[]] | T[]} array 
 * @returns {array is [T[]]}
 */
function has_one_element(array) {
  return array.length === 1;
}

/** @param  {[Promise[]] | Promise[]} promises */
export function all_promises(...promises) {
  if (has_one_element(promises)) { 
    return Promise.all((promises[0]));
  } else {
    return Promise.all(promises);
  }
}

/** @param  {[Promise[]] | Promise[]} promises */
export function race_promises(...promises) {
  if (has_one_element(promises)) {
    return Promise.race(promises[0]);
  } else {
    return Promise.race(promises);
  }
}

export function map_new() {
  return new Map();
}

/**
 * @template K, V
 * @param {Map<K,V>} map 
 * @param {K} key 
 * @param {V} value 
 */
export function map_set(map, key, value) {
  return map.set(key, value);
}

/**
 * @template K, V
 * @param {Map<K,V>} map 
 * @param {K} key 
 * @returns {Ok<V|undefined,undefined> | Error<V|undefined,undefined>}
 */
export function map_get(map, key) {
  if (map.has(key)) {
    return new Ok(map.get(key));
  }
  return new Error(undefined);
}

/**
 * @template K, V
 * @param {Map<K,V>} map 
 */
export function map_size(map) {
  return map.size;
}
