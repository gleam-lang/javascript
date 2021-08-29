import gleam/javascript/array

pub fn to_and_from_list_test() {
  assert [] =
    []
    |> array.from_list
    |> array.to_list

  assert [1, 2, 3] =
    [1, 2, 3]
    |> array.from_list
    |> array.to_list
}

pub fn length_test() {
  assert 0 =
    array.from_list([])
    |> array.length

  assert 2 =
    array.from_list([1, 2])
    |> array.length
}

pub fn map_test() {
  assert [] =
    []
    |> array.from_list
    |> array.map(fn(a) { a + 1 })
    |> array.to_list

  assert [2, 3, 4] =
    [1, 2, 3]
    |> array.from_list
    |> array.map(fn(a) { a + 1 })
    |> array.to_list
}

pub fn fold_test() {
  assert [] =
    []
    |> array.from_list
    |> array.fold([], fn(a, e) { [e, ..a] })

  assert [4, 3, 2, 1] =
    [1, 2, 3, 4]
    |> array.from_list
    |> array.fold([], fn(a, e) { [e, ..a] })

  assert [1, 2, 3, 4] =
    [4, 3, 2, 1]
    |> array.from_list
    |> array.fold([], fn(a, e) { [e, ..a] })
}

pub fn fold_right_test() {
  assert [] =
    []
    |> array.from_list
    |> array.fold_right([], fn(a, e) { [e, ..a] })

  assert [1, 2, 3, 4] =
    [1, 2, 3, 4]
    |> array.from_list
    |> array.fold_right([], fn(a, e) { [e, ..a] })

  assert [4, 3, 2, 1] =
    [4, 3, 2, 1]
    |> array.from_list
    |> array.fold_right([], fn(a, e) { [e, ..a] })
}
