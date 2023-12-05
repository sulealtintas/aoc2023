defmodule AdventOfCode.Day03Test do
  use ExUnit.Case
  import AdventOfCode.Day03

  setup_all do
    {:ok, input} = File.read("test/day03/input.txt")
    {:ok, input: input}
  end

  test "puzzle 1", %{input: test_input} do
    assert puzzle1(test_input) == 4361
  end

  test "puzzle 2", %{input: test_input} do
    assert puzzle2(test_input) == 467_835
  end

  test "solution" do
    assert(solution() == %{p1: 533_775, p2: 78_236_071})
  end
end
