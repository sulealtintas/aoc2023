defmodule AdventOfCode.Day02 do
  @spec input :: String.t()
  def input, do: AdventOfCode.read_input(2)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @max_balls %{"red" => 12, "green" => 13, "blue" => 14}

  @spec puzzle1(String.t()) :: integer()
  def puzzle1(input) do
    input
    |> get_games()
    |> Enum.map(&balls_shown_by_color/1)
    |> Enum.with_index(1)
    |> Enum.reject(fn {balls_shown, _idx} ->
      Enum.any?(Map.keys(balls_shown), fn key -> balls_shown[key] > @max_balls[key] end)
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  @spec puzzle2(String.t()) :: integer()
  def puzzle2(input) do
    input
    |> get_games()
    |> Enum.map(&balls_shown_by_color/1)
    |> Enum.map(&Map.values/1)
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end

  defp get_games(input) do
    input
    |> String.split("\n")
    |> Enum.flat_map(&get_game/1)
  end

  defp get_game(line) do
    line
    |> String.split([":"])
    |> Enum.drop(1)
    |> Enum.map(&parse_game/1)
  end

  defp parse_game(game) do
    game
    |> String.split([";", ","])
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [balls, color] -> [String.to_integer(balls), color] end)
  end

  defp balls_shown_by_color(game) do
    Enum.reduce(game, %{}, fn [balls, color], acc ->
      Map.update(acc, color, balls, fn value ->
        max(balls, value)
      end)
    end)
  end
end
