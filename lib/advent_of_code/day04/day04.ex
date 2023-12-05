defmodule AdventOfCode.Day04 do
  @spec input :: String.t()
  def input, do: AdventOfCode.read_input(4)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @spec puzzle1(String.t()) :: integer()
  def puzzle1(input) do
    input
    |> parse_input()
    |> Enum.map(fn [winning, own] -> [MapSet.new(winning), MapSet.new(own)] end)
    |> Enum.map(fn [winning, own] -> MapSet.intersection(winning, own) end)
    |> Enum.map(&MapSet.size/1)
    |> Enum.filter(&(&1 > 0))
    |> Enum.map(&(2 ** (&1 - 1)))
    |> Enum.sum()
  end

  @spec puzzle2(String.t()) :: integer()
  def puzzle2(_input) do
    0
  end

  defp parse_input(input) do
    for line <- String.split(input, "\n"),
        round <- Regex.scan(~r/(?:Card\s+\d+:)\s(.+)\s\|\s(.+)/, line, capture: :all_but_first) do
      for numbers <- Enum.map(round, &String.split(&1)) do
        Enum.map(numbers, &String.to_integer/1)
      end
    end
  end
end
