#/bin/bash
set -eu

library_dir() {
  echo "lib/$1"
}

library_out_dir() {
  echo "node_modules/$1"
}

clone_dep() {
  local dir=$(library_dir "$1")
  local tag="$2"
  local url="$3"

  if [ ! -d "$dir" ] ; then
    mkdir -p lib
    git clone --depth=1 --branch="$tag" "$url" "$dir"
  fi
}

compile_library() {
  local name="$1"
  echo "Compiling $name"

  shift
  local lib_flags=()
  for dep in "$@"; do
    lib_flags+=("--lib=$(library_out_dir $dep)")
  done

  local dir=$(library_dir "$name")
  local src="$dir/src"
  local test="$dir/test"
  local out=$(library_out_dir "$name")
  rm -rf out

  gleam compile-package \
    --name "$name" \
    --target javascript \
    --src "$src" \
    --out $(library_out_dir "$name") \
    "${lib_flags[@]: }"

  cp "$src/"*.js "$out/"
}

clone_dep gleam_stdlib main https://github.com/gleam-lang/stdlib.git
compile_library gleam_stdlib

rm -rf node_modules/gleam_javascript
gleam compile-package \
  --name gleam_javascript \
  --target javascript \
  --src src \
  --test test \
  --out node_modules/gleam_javascript \
  --lib node_modules/gleam_stdlib
cp "src/"*.js "node_modules/gleam_javascript/"

node bin/run-tests.js
