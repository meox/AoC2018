defmodule Day1 do
  @moduledoc """
  Day1 of AoC 2018.
  """

  def calc_freq do
    load_input()
    |> Enum.reduce(0, fn x, acc ->
      acc + String.to_integer(x)
    end)
  end

  def twice do
    load_input()
    |> Stream.cycle
    |> Enum.reduce_while({0, %{}}, fn n, {freq, map} ->
      n_freq = freq + n
      n_map = Map.update(map, n_freq, 1, &(&1 + 1))
      check_map(n_freq, n_map)
    end)
  end

  ##### PRIVATE #####

  defp check_map(freq, map) do
    if Map.get(map, freq) == 2 do
      {:halt, freq}
    else
      {:cont, {freq, map}}
    end
  end

  defp load_input do
    File.stream!("./input.txt")
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.filter(fn x ->
      x != ""
    end)
    |> Enum.map(fn x ->
      String.to_integer(x)
    end)
  end
end
