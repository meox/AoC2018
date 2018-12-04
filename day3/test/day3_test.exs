defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "parsing" do
    assert Day3.parse_claim("#1 @ 1,3: 4x4") == %Claim{id: 1, x: 1, y: 3, w: 4, h: 4}
    assert Day3.parse_claim("#2 @ 3,1: 4x4") == %Claim{id: 2, x: 3, y: 1, w: 4, h: 4}
  end

  test "overlap 1" do
    claim_a = Day3.parse_claim("#1 @ 1,3: 4x4")
    claim_b = Day3.parse_claim("#2 @ 3,1: 4x4")

    assert Day3.overlap(claim_a, claim_b, MapSet.new()) ==
             MapSet.new([{3, 3}, {3, 4}, {4, 3}, {4, 4}])
  end

  test "overlap 2" do
    claims = [
      Day3.parse_claim("#1 @ 1,3: 4x4"),
      Day3.parse_claim("#2 @ 3,1: 4x4"),
      Day3.parse_claim("#3 @ 5,5: 2x2")
    ]

    assert Day3.overlap(claims) == MapSet.new([{3, 3}, {3, 4}, {4, 3}, {4, 4}])
  end
end
