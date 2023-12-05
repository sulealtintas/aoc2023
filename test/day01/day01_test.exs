defmodule AdventOfCode.Day01Test do
  use ExUnit.Case
  import AdventOfCode.Day01

  setup_all do
    {:ok, input1} = File.read("test/day01/input1.txt")
    {:ok, input2} = File.read("test/day01/input2.txt")
    {:ok, input1: input1, input2: input2}
  end

  test "puzzle 1", %{input1: test_input} do
    assert puzzle1(test_input) == 142
  end

  test "puzzle 2", %{input2: test_input} do
    assert puzzle2(test_input) == 281
  end

  test "solution" do
    assert(solution() == %{p1: 54159, p2: 53866})
  end
end
