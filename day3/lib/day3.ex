defmodule Day3 do
  @edge 1000

  def calc_space do
    load_input()
    |> Enum.map(&parse_claim/1)
    |> overlap()
    |> Enum.count()
  end

  def find_id() do
    claims = load_input()
      |> Enum.map(&parse_claim/1)

    overlaps =
      claims
      |> overlap()

    claims
    |> Enum.find(fn c ->
      MapSet.disjoint?(overlaps, points(c))
    end)
  end

  def overlap(claims) when is_list(claims) do
    claims_map =
      Enum.reduce(claims, %{}, fn x, acc ->
        Map.put_new(acc, x.id, x)
      end)

    ids = Map.keys(claims_map)

    combines =
      for x <- ids,
          y <- ids,
          x != y and x < y,
          do: {x, y}

    combines
    |> Enum.reduce(MapSet.new(), fn {idx_a, idx_b}, cross ->
      claim_a = Map.get(claims_map, idx_a)
      claim_b = Map.get(claims_map, idx_b)
      overlap(claim_a, claim_b, cross)
    end)
  end

  def overlap(%Claim{} = a, %Claim{} = b, cross) do
    cond do
      a.x + a.w <= b.x || b.x + b.w <= a.x ->
        cross

      a.y + a.h <= b.y || b.y + b.h <= a.y ->
        cross

      true ->
        MapSet.intersection(points(a), points(b))
        |> MapSet.union(cross)
    end
  end

  def points(%Claim{x: x, y: y, w: w, h: h}) do
    for cx <- x..(x + w - 1),
        cy <- y..(y + h - 1) do
      {cx, cy}
    end
    |> MapSet.new()
  end

  def parse_claim(claim) do
    # 1 @ 662,777: 18x27
    [id, left, top, w, h] =
      ~r/^\#(\d+) \@ (\d+),(\d+): (\d+)x(\d+)$/
      |> Regex.run(claim)
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)

    %Claim{id: id, x: left, y: top, w: w, h: h}
  end

  defp load_input do
    File.stream!("./puzzle.txt")
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.filter(fn x -> x != "" end)
  end
end
