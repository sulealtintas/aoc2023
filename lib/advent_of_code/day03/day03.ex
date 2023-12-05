defmodule AdventOfCode.Day03 do
  @spec input :: String.t()
  def input, do: AdventOfCode.read_input(3)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @spec puzzle1(String.t()) :: integer()
  def puzzle1(input) do
    {numbers, symbols} = parse_input(input)

    numbers
    |> get_engine_parts(symbols)
    |> Enum.sum()
  end

  @spec puzzle2(String.t()) :: integer()
  def puzzle2(input) do
    {numbers, symbols} = parse_input(input)
    asterisks = Enum.filter(symbols, fn {_k, v} -> v == "*" end)

    numbers
    |> find_gears(asterisks)
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end

  defp parse_input(input) do
    {digits, symbols} =
      input
      |> to_grid()
      |> Enum.split_with(fn {_, c} -> String.match?(c, ~r/\d/) end)

    {get_number_ranges(digits), Map.new(symbols)}
  end

  defp to_grid(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(&parse_line/1)
  end

  defp parse_line({line, i}) do
    line
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.reject(fn {c, _} -> c == "." end)
    |> Enum.map(fn {c, j} -> {{i, j}, c} end)
  end

  defp get_number_ranges(digits) do
    digits
    |> chunk_digits()
    |> Enum.map(fn {coord_list = [head | _], digits} ->
      number = digits |> List.to_string() |> String.to_integer()
      i = elem(head, 0)
      j_range = elem(head, 1)..elem(List.last(coord_list), 1)
      {{i, j_range}, number}
    end)
    |> Enum.into(%{})
  end

  defp chunk_digits([head | tail]) do
    chunk_fun = fn element = {{i, j}, _}, acc = [{{i_prev, j_prev}, _} | _] ->
      if i == i_prev and j == j_prev + 1 do
        {:cont, [element | acc]}
      else
        {:cont, acc, [element]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, acc, []}
    end

    tail
    |> Enum.chunk_while([head], chunk_fun, after_fun)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&Enum.unzip/1)
  end

  defp get_engine_parts(numbers, symbols) do
    numbers
    |> Enum.filter(fn {number_coords, _} ->
      Enum.any?(adjacent_coordinates(number_coords), fn coords ->
        Map.has_key?(symbols, coords)
      end)
    end)
    |> Enum.map(&elem(&1, 1))
  end

  defp find_gears(numbers, asterisks) do
    asterisks
    |> Enum.map(fn {{i, j}, _} ->
      find_adjacent_numbers({i, j}, numbers)
    end)
    |> Enum.filter(&(length(&1) == 2))
  end

  defp find_adjacent_numbers({i, j}, numbers) do
    numbers
    |> Enum.filter(fn {coords, _} ->
      Enum.member?(adjacent_coordinates(coords), {i, j})
    end)
    |> Enum.map(&elem(&1, 1))
  end

  defp adjacent_coordinates({i, j1..j2}) do
    adjacent_coordinates({i, j1}) ++ adjacent_coordinates({i, j2})
  end

  defp adjacent_coordinates({i, j}) do
    for di <- -1..1,
        dj <- -1..1,
        di != 0 or dj != 0,
        do: {i + di, j + dj}
  end
end
