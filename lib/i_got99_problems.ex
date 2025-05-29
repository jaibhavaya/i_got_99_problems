defmodule IGot99Problems do
  @moduledoc """
  Just like the 99 ocaml problems (which I think was based on 99 lisp problems)
  ...but in elixir
  ...because Jose Valim is king

  """

  def trace(method) do
    Rexbug.start("IGot99Problems#{method}/_ :: return")
  end

  # 1
  @doc """
  Retrieves the last item of a list

  ## Examples

      iex> IGot99Problems.last([1,2,3,4])
      4
      iex> IGot99Problems.last([])
      nil

  """
  def last([]), do: nil
  def last([x]), do: x
  def last([_ | t]), do: t |> last

  # 2
  @doc """
  Retrieves the last two items of a list

  ## Examples

      iex> IGot99Problems.last_two([1,2,3,4])
      [ 3,4 ]
      iex> IGot99Problems.last_two([1])
      [ nil, 1 ]
      iex> IGot99Problems.last_two([])
      [ nil, nil ]

  """
  def last_two([]), do: [nil, nil]
  def last_two([x]), do: [nil, x]
  def last_two([x, y]), do: [x, y]
  def last_two([_ | t]), do: t |> last_two

  # 3
  @doc """
  Retrieves the nth item of the list

  ## Examples

      iex> IGot99Problems.at(2, [1,2,3,4])
      3

  """
  def at(_, []), do: nil
  def at(0, [x | _]), do: x
  def at(i, [_ | t]), do: at(i - 1, t)

  # 4
  @doc """
  Calculates the length of a list

  ## Examples

      iex> IGot99Problems.length([1,2,3,4])
      4

  """
  def length(list), do: length(0, list)

  @doc false
  def length(idx, []), do: idx
  def length(idx, [_ | t]), do: length(idx + 1, t)

  # 5
  @doc """
  Reverses a list

  ## Examples

      iex> IGot99Problems.reverse([1,2,3,4])
      [4,3,2,1]

  """
  def reverse(list), do: [] |> reverse(list)

  @doc false
  def reverse(acc, []), do: acc
  def reverse(acc, [x | t]), do: reverse([x | acc], t)

  # 6
  @doc """
  Checks if the list is a palindrome

  ## Examples

      iex> IGot99Problems.palindrome?([1,2,3,4])
      false
      iex> IGot99Problems.palindrome?([4,3,1,3,4])
      true
      iex> IGot99Problems.palindrome?([4,3,3,4])
      true

  """
  def palindrome?(list), do: list |> reverse |> palindrome?(list)

  @doc false
  def palindrome?([], []), do: true
  def palindrome?([r | rt], [l | lt]) when r == l, do: rt |> palindrome?(lt)
  def palindrome?(_, _), do: false

  # 7
  @doc """
  Flattens a list

  ## Examples

      iex> IGot99Problems.flatten([1,2,3,4])
      [1,2,3,4]
      iex> IGot99Problems.flatten([1, 2, [3,4]])
      [1,2,3,4]
      iex> IGot99Problems.flatten([1, 2, []])
      [1,2]

  """
  def flatten(list), do: [] |> flatten(list) |> reverse

  @doc false
  def flatten(acc, []), do: acc
  def flatten(acc, [x | t]) when is_list(x), do: acc |> flatten(x) |> flatten(t)
  def flatten(acc, [x | t]), do: [x | acc] |> flatten(t)

  # 8
  @doc """
  Eliminates consecutive duplicates in a list

  ## Examples

      iex> IGot99Problems.compress([1,2,3,4])
      [1,2,3,4]
      iex> IGot99Problems.compress([1, 2, 2, 3, 4])
      [1,2,3,4]
      iex> IGot99Problems.compress([])
      []

  """
  def compress([]), do: []
  def compress([x]), do: [x]
  def compress([x, x | t]), do: [x | t] |> compress
  def compress([x, y | t]), do: [x | [y | t] |> compress]

  # 9
  @doc """
  Pack consecutive duplicates into sublists

  ## Examples

      iex> IGot99Problems.pack([1,2,3,4])
      [[1],[2],[3],[4]]
      iex> IGot99Problems.pack([1,2,2,3,4])
      [[1],[2,2],[3],[4]]

  """
  def pack(list), do: pack([], [], list) |> reverse

  @doc false
  def pack(acc, [], []), do: acc
  def pack(acc, current, [x]), do: [[x | current] | acc]
  def pack(acc, current, [x, x | t]), do: pack(acc, [x | current], [x | t])
  def pack(acc, current, [x, y | t]), do: pack([[x | current] | acc], [], [y | t])

  # 10
  @doc """
  Run length encoding

  ## Examples

      iex> IGot99Problems.encode([1,2,3,4])
      [{1,1},{1,2},{1,3},{1,4}]
      iex> IGot99Problems.encode([1,2,2,3,4])
      [{1,1},{2,2},{1,3},{1,4}]

  """
  def encode(list), do: encode([], 0, list) |> reverse

  @doc false
  def encode(acc, 0, []), do: acc
  def encode(acc, count, [x]), do: [{count + 1, x} | acc]
  def encode(acc, count, [x, x | t]), do: encode(acc, count + 1, [x | t])
  def encode(acc, count, [x, y | t]), do: encode([{count + 1, x} | acc], 0, [y | t])

  # 11
  @doc """
  Modified run length encoding

  ## Examples

      iex> IGot99Problems.modified_encode([1,2,3,4])
      [1,2,3,4]
      iex> IGot99Problems.modified_encode([1,2,2,3,4])
      [1,{2,2},3,4]

  """
  def modified_encode(list), do: modified_encode([], 0, list) |> reverse

  @doc false
  def modified_encode(acc, 0, []), do: acc
  def modified_encode(acc, count, [x]), do: [create(count + 1, x) | acc]

  def modified_encode(acc, count, [x, x | t]), do: modified_encode(acc, count + 1, [x | t])

  def modified_encode(acc, count, [x, y | t]),
    do: modified_encode([create(count + 1, x) | acc], 0, [y | t])

  defp create(1, elem), do: elem
  defp create(count, elem), do: {count, elem}

  # 12
  @doc """
  Decode run length encoding

  ## Examples

      iex> IGot99Problems.decode([1,2,3,4])
      [1,2,3,4]
      iex> IGot99Problems.decode([1,{2,2},3,4])
      [1,2,2,3,4]

  """
  def decode(list), do: decode([], list) |> reverse

  @doc false
  def decode(acc, []), do: acc
  def decode(acc, [x]), do: acc |> add_to_acc(x)
  def decode(acc, [x | t]), do: acc |> add_to_acc(x) |> decode(t)

  defp add_to_acc(acc, {0, _}), do: acc
  defp add_to_acc(acc, {count, elem}), do: [elem | acc] |> add_to_acc({count - 1, elem})
  defp add_to_acc(acc, elem), do: [elem | acc]

  # 13 (already done, was an optimization to run length encoding, but the optimization was the way I originally solved it.

  # 14
  @doc """
  Duplicate elements of list

  ## Examples

      iex> IGot99Problems.duplicate([1,2,3,4])
      [1,1,2,2,3,3,4,4]

  """
  def duplicate(list), do: [] |> duplicate(list) |> reverse

  @doc false
  def duplicate(acc, []), do: acc
  def duplicate(acc, [x]), do: [x | [x | acc]]
  def duplicate(acc, [x | t]), do: duplicate([x | [x | acc]], t)

  # 15
  @doc """
  Replicate elements of list n times

  ## Examples

      iex> IGot99Problems.replicate([1,2,3,4], 3)
      [1,1,1,2,2,2,3,3,3,4,4,4]
      iex> IGot99Problems.replicate([1,2,3,4], 1)
      [1,2,3,4]

  """
  def replicate(list, n), do: [] |> replicate(list, n) |> reverse

  @doc false
  def replicate(acc, [], _), do: acc
  def replicate(acc, [x | t], n), do: acc |> to_acc(x, n) |> replicate(t, n)

  defp to_acc(acc, _, 0), do: acc
  defp to_acc(acc, x, n), do: [x | acc] |> to_acc(x, n - 1)

  # 16
  @doc """
  Drop every nth element of list

  ## Examples

      iex> IGot99Problems.drop_every([1,2,3,4], 2)
      [1,3]

  """
  def drop_every(list, n), do: [] |> drop_every(list, n, n) |> reverse

  @doc false
  def drop_every(acc, [], _n, _counter), do: acc
  def drop_every(acc, [_ | t], n, 1), do: acc |> drop_every(t, n, n)
  def drop_every(acc, [h | t], n, counter), do: [h | acc] |> drop_every(t, n, counter - 1)

  # 17
  @doc """
  split list at given length

  ## examples

      iex> IGot99Problems.split([1,2,3,4], 2)
      {[1,2],[3,4]}

  """
  def split(list, n), do: [] |> split(list, n)

  def split(acc, [], _), do: {acc, []}
  def split(acc, [h | t], 1), do: {[h | acc] |> reverse, t}
  def split(acc, [h | t], n), do: split([h | acc], t, n - 1)

  # 18
  @doc """
  slice list from start idx to end idx

  ## examples

      iex> IGot99Problems.slice([1,2,3,4, 5, 6, 7], 2, 5)
      [3,4,5,6]

  """
  def slice(list, b, e), do: [] |> slice(list, b, e, 0) |> reverse

  @doc false
  def slice(acc, [], _, _, _), do: acc

  def slice(acc, [h | t], b, e, current) when b <= current and current <= e,
    do: slice([h | acc], t, b, e, current + 1)

  def slice(acc, [_ | t], b, e, current), do: slice(acc, t, b, e, current + 1)

  def slice(acc, _, _, _, _), do: acc

  # 19
  @doc """
  rotates a list at given index

  ## examples

      iex> IGot99Problems.rotate([1,2,3,4, 5, 6, 7], 2)
      [3,4,5,6,7,1,2]

  """
  def rotate(list, n), do: [] |> rotate(list, n, 0)

  @doc false
  def rotate(acc, [], _, _), do: acc

  def rotate(acc, [h | t], n, current) when current == n,
    do: [h | t] ++ (acc |> reverse)

  def rotate(acc, [h | t], n, current), do: rotate([h | acc], t, n, current + 1)

  # 20
  @doc """
  removes the n'th element from a list

  ## examples

      iex> IGot99Problems.remove_at([1,2,3,4, 5, 6, 7], 2)
      [1,2,4,5,6,7]

  """
  def remove_at(list, n), do: [] |> remove_at(list, n, 0)

  @doc false
  def remove_at(acc, [], _, _), do: acc

  def remove_at(acc, [_ | t], n, current) when current == n,
    do: (acc |> reverse) ++ t

  def remove_at(acc, [h | t], n, current), do: remove_at([h | acc], t, n, current + 1)

  # 21
  @doc """
  inserts an element into a list at a given index

  ## examples

      iex> IGot99Problems.insert_at(100, 3, [1,2,3,4, 5, 6,7])
      [1,2,3,100,4,5,6,7]

  """
  def insert_at(item, n, list), do: [] |> insert_at(item, n, list, 0)

  @doc false
  def insert_at(acc, _, _, [], _), do: acc

  def insert_at(acc, item, n, [h | t], current) when current == n,
    do: (acc |> reverse) ++ [item, h] ++ t

  def insert_at(acc, item, n, [h | t], current), do: insert_at([h | acc], item, n, t, current + 1)

  # 22
  @doc """
  creates a list of the integers in the given range

  ## examples

      iex> IGot99Problems.range(2,7)
      [2,3,4,5,6,7]

  """
  def range(b, e), do: [] |> range(b, e, 0) |> reverse

  @doc false
  def range(acc, _, e, current) when current > e, do: acc

  def range(acc, b, e, current) when b <= current and current <= e,
    do: range([current | acc], b, e, current + 1)

  def range(acc, b, e, current), do: range(acc, b, e, current + 1)
end
