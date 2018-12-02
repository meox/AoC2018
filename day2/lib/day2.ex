defmodule Day2 do
  @moduledoc """
  Day2 of AoC 2018.
  """

  def checksum do
    load_input()
    |> Enum.map(fn box_id -> parse_boxid(box_id) end)
    |> Enum.reduce({0, 0}, fn {a, b}, {twos, threes} ->
      {twos + a, threes + b}
    end)
    |> calc_checksum()
  end

  def parse_boxid(box_id) do
    box_id
    |> String.trim()
    |> String.split("")
    |> Enum.filter(&(&1 != ""))
    |> Enum.reduce(%{}, fn x, acc ->
      Map.update(acc, x, 1, &(&1 + 1))
    end)
    |> Enum.reduce({0, 0}, fn
      {_k, 2}, {twos, threes} ->
        {twos + 1, threes}
      {_k, 3}, {twos, threes} ->
        {twos, threes + 1}
      {_k, _v}, {twos, threes} ->
        {twos, threes}
    end)
    |> normalize()
  end

  def similar do
    load_input()
    |> Enum.map(&split_it/1)
    |> check_similar()
  end

  def check_similar([]), do: ""
  def check_similar([x | xs]) do
    xs
    |> Enum.reduce_while({}, fn current, _acc ->
      check_element(x, current)
    end)
    |> continue_check(xs)
  end

  ##### PRIVATE #####

  defp continue_check({:found, xs, ys}, _xs) do
    xs
    |> Enum.reduce({0, []}, fn x, {i, acc} ->
      case Enum.at(ys, i) do
        ^x -> {i + 1, [x | acc]}
        _ -> {i + 1, acc}
      end
    end)
    |> (fn {_, rs} -> rs end).()
    |> Enum.reverse()
    |> Enum.join("")
  end

  defp continue_check(:not_found, xs), do: check_similar(xs)

  defp check_element(x, y) do
    c = Enum.zip(x, y)
    |> Enum.filter(fn {a, b} -> a != b end)
    |> Enum.count()
    if c == 1 do
      {:halt, {:found, x, y}}
    else
      {:cont, :not_found}
    end
  end

  def split_it(box_id) do
    box_id
    |> String.split("")
    |> Enum.filter(fn x -> x != "" end)
  end

  defp calc_checksum({twos, threes}), do: twos * threes

  defp normalize({twos, threes}), do: {norm(twos), norm(threes)}
  defp norm(0), do: 0
  defp norm(_x), do: 1

  defp load_input do
    File.stream!("./puzzle.txt")
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.sort()
  end
end
