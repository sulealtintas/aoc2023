defmodule AdventOfCode.Day04Test do
  use ExUnit.Case
  import AdventOfCode.Day04

  setup_all do
    {:ok, input} = File.read("test/day04/input.txt")
    {:ok, input: input}
  end

  test "puzzle 1", %{input: test_input} do
    assert puzzle1(test_input) == 13
  end

  test "puzzle 2", %{input: test_input} do
    assert puzzle2(test_input) == 30
  end

  test "solution" do
    assert(solution() == %{p1: 22674, p2: nil})
  end
end
