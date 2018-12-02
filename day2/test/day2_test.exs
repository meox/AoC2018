defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "simple box id" do
    assert Day2.parse_boxid("abcdef") == {0, 0}
    assert Day2.parse_boxid("bababc") == {1, 1}
    assert Day2.parse_boxid("ababab") == {0, 1}
    assert Day2.parse_boxid("aabcdd") == {1, 0}
    assert Day2.parse_boxid("abbcde") == {1, 0}
  end

  test "similar: empty" do
    assert Day2.check_similar([]) == ""
  end

  test "check_similar" do
    list = [
      "abcde",
      "fghij",
      "klmno",
      "pqrst",
      "fguij",
      "axcye",
      "wvxyz"
    ]
    |> Enum.map(&Day2.split_it/1)

    assert Day2.check_similar(list) == "fgij"
  end
end
