defmodule AdventOfCode do
  @spec read_input(integer) :: binary
  def read_input(day) do
    day_padded = String.pad_leading(Integer.to_string(day), 2, "0")
    {:ok, input} = File.read("lib/advent_of_code/day#{day_padded}/input.txt")
    input
  end
end
