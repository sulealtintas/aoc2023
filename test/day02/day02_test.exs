defmodule AdventOfCode.Day02Test do
  use ExUnit.Case
  import AdventOfCode.Day02

  setup_all do
    {:ok, input} = File.read("test/day02/input.txt")
    {:ok, input: input}
  end

  test "puzzle 1", %{input: test_input} do
    assert puzzle1(test_input) == 8
  end

  test "puzzle 2", %{input: test_input} do
    assert puzzle2(test_input) == 2286
  end

  test "solution" do
    assert(solution() == %{p1: 2283, p2: 78669})
  end
end
