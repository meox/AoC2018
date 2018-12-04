defmodule Day3 do
  @edge 1000

  def calc_space do
  end

  def overlap(claims, cross) where is_array(claims) do
    Enum.
  end

  end
  def overlap(%Claim{} = a, %Claim{} = b, cross) do
    cond do
      a.x + a.w <= b.x ->
        []

      b.x + b.w <= a.x ->
        []

      a.y + a.h <= b.y ->
        []

      b.y + b.h <= a.y ->
        []

      true ->
        points(a) |> MapSet.new
        |> MapSet.intersection(points(b) |> MapSet.new)
        |> MapSet.intersection(cross |> MapSet.new)
        |> Enum.to_list()
    end
  end

  def points(%Claim{x: x, y: y, w: w, h: h}) do
    for cx <- x..(x + w - 1),
        cy <- y..(y + h - 1) do
      {cx, cy}
    end
  end

  def parse_line(claim) do
    # 1 @ 662,777: 18x27
    ~r/^\#(\d+) \@ (\d+),(\d+): (\d+)x(\d+)$/
    |> Regex.run(claim)
    |> Enum.drop(1)
    |> Enum.map(fn x ->
      [id, left, top, w, h] = String.to_integer(x)
      %Claim{id: id, x: left, y: top, w: w, h: h}
    end)
  end

  defp load_input do
    File.stream!("./puzzle.txt")
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.filter(fn x -> x != "" end)
  end
end
