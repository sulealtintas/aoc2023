defmodule AdventOfCode.Day01 do
  @spec input :: String.t()
  def input, do: AdventOfCode.read_input(1)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @digits %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  @spec puzzle1(String.t()) :: integer()
  def puzzle1(input) do
    input
    |> get_calibration_value(named_digits: false)
    |> Enum.sum()
  end

  @spec puzzle2(String.t()) :: integer()
  def puzzle2(input) do
    input
    |> get_calibration_value(named_digits: true)
    |> Enum.sum()
  end

  defp get_calibration_value(input, named_digits: named_digits) when is_binary(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&find_all_digits(&1, named_digits: named_digits))
    |> Enum.map(&get_calibration_value(&1, named_digits: named_digits))
  end

  defp get_calibration_value(digits, named_digits: named_digits) when is_list(digits) do
    digits
    |> List.flatten()
    |> then(&[List.first(&1), List.last(&1)])
    |> convert_digits_to_integer(named_digits: named_digits)
  end

  defp find_all_digits(line, named_digits: false) do
    Regex.scan(~r/\d/, line)
  end

  defp find_all_digits(line, named_digits: true) do
    Regex.scan(~r/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/, line,
      capture: :all_but_first
    )
  end

  defp convert_digits_to_integer(digits, named_digits: false) do
    digits
    |> List.to_string()
    |> String.to_integer()
  end

  defp convert_digits_to_integer(digits, named_digits: true) do
    digits
    |> Enum.map(&Map.get(@digits, &1, &1))
    |> convert_digits_to_integer(named_digits: false)
  end
end
