defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "basic overlap" do
    claim_a = Day3.parse_line("#1 @ 1,3: 4x4")
    claim_b = Day3.parse_line("#2 @ 3,1: 4x4")
    claim_c = Day3.parse_line("#3 @ 5,5: 2x2")

    Day3.overlap(claim_a, claim_b)
  end
end
