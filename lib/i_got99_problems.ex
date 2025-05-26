defmodule IGot99Problems do
  @moduledoc """
  Just like the 99 ocaml problems (which I think was based on 99 lisp problems)
  ...but in elixir
  ...because Jose Valim is king

  """

  @doc """
  1. Retrieves the last item of a list

  ## Examples

      iex> IGot99Problems.last([1,2,3,4])
      4
      iex> IGot99Problems.last([])
      nil

  """
  def last([]), do: nil
  def last([x]), do: x
  def last([_ | t]), do: last(t)

  @doc """
  2. Retrieves the last two items of a list

  ## Examples

      iex> IGot99Problems.last_two([1,2,3,4])
      [3,4]

  """
  def last_two([]), do: []
  def last_two([x]), do: x
  def last_two([x, y]), do: [x, y]
  def last_two([_ | t]), do: last_two(t)

  @doc """
  3. Retrieves the nth item of the list

  ## Examples

      iex> IGot99Problems.at(2, [1,2,3,4])
      3

  """
  def at(_, []), do: nil
  def at(0, [x | _]), do: x
  def at(i, [_ | t]), do: at(i - 1, t)

  @doc """
  4. Calculates the length of a list

  ## Examples

      iex> IGot99Problems.length([1,2,3,4])
      4

  """
  def length(list), do: length(0, list)

  @doc false
  def length(idx, []), do: idx
  def length(idx, [_ | t]), do: length(idx + 1, t)

  @doc """
  5. Reverses a list

  ## Examples

      iex> IGot99Problems.reverse([1,2,3,4])
      [4,3,2,1]

  """
  def reverse(list), do: reverse([], list)

  @doc false
  def reverse(acc, []), do: acc
  def reverse(acc, [x | t]), do: reverse([x | acc], t)

  @doc """
  6. Checks if the list is a palindrome

  ## Examples

      iex> IGot99Problems.palindrome?([1,2,3,4])
      false
      iex> IGot99Problems.palindrome?([4,3,1,3,4])
      true
      iex> IGot99Problems.palindrome?([4,3,3,4])
      true

  """
  def palindrome?(list), do: palindrome?(reverse(list), list)

  @doc false
  def palindrome?([], []), do: true
  def palindrome?([r | rt], [l | lt]) when r == l, do: palindrome?(rt, lt)
  def palindrome?(_, _), do: false

  @doc """
  7. Flattens a list

  ## Examples

      iex> IGot99Problems.flatten([1,2,3,4])
      [1,2,3,4]
      iex> IGot99Problems.flatten([1, 2, [3,4]])
      [1,2,3,4]
      iex> IGot99Problems.flatten([1, 2, []])
      [1,2]

  """
  def flatten(list), do: reverse(flatten([], list))

  @doc false
  def flatten(acc, []), do: acc
  def flatten(acc, [x | t]) when is_list(x), do: flatten(flatten(acc, x), t)
  def flatten(acc, [x | t]), do: flatten([x | acc], t)

  @doc """
  8. Eliminates consecutive duplicates in a list

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
  def compress([x, x | t]), do: compress([x | t])
  def compress([x, y | t]), do: [x | compress([y | t])]

  @doc """
  9. Pack consecutive duplicates into sublists
  TODO

  ## Examples

      iex> IGot99Problems.pack([])
      []
      iex> IGot99Problems.pack([1,2,3,4])
      [1,2,3,4]
      iex> IGot99Problems.pack([1, 2, 2, 3, 4])
      [1,[2, 2],3,4]

  """
  def pack([]), do: []
end
