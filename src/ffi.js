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
