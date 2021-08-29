#/bin/bash
set -eu

library_dir() {
  echo "_build/deps/$1"
}

project_dir() {
  echo "_build/lib/$1"
}

clone_dep() {
  local dir=$(library_dir "$1")
  local tag="$2"
  local url="$3"

  if [ ! -d "$dir" ] ; then
    mkdir -p "$dir"
    git clone --depth=1 --branch="$tag" "$url" "$dir"
  fi
}

compile_library() {
  local name="$1"
  echo "Compiling $name"

  shift
  local lib_flags=()
  for dep in "$@"; do
    lib_flags+=("--lib=$(project_dir $dep)")
  done

  local dir=$(library_dir "$name")
  local src="$dir/src"
  local out=$(project_dir "$name")


  if [ ! -d "$out" ] ; then
    gleam compile-package \
      --name "$name" \
      --target javascript \
      --src "$src" \
      --out $(project_dir "$name") \
      "${lib_flags[@]: }"
    cp "$src/"*.js "$out/"
  fi
}

clone_dep gleam_stdlib main https://github.com/gleam-lang/stdlib.git
compile_library gleam_stdlib

rm -rf $(project_dir gleam_javascript)
gleam compile-package \
  --name gleam_javascript \
  --target javascript \
  --src src \
  --test test \
  --out $(project_dir gleam_javascript) \
  --lib $(project_dir gleam_stdlib)
cp "src/"*.js $(project_dir gleam_javascript)/

node bin/run-tests.js
