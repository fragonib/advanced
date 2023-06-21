defmodule Protocols.MyEnumerable do
  def map(enumerable, function) do
    Enumerable.reduce(enumerable, {:cont, []}, fn x, acc ->
      {:cont, acc ++ [function.(x)]}
    end)
    |> elem(1)
  end

  def filter(enumerable, function) do
    Enumerable.reduce(enumerable, {:cont, []}, fn x, acc ->
      {:cont, if(function.(x), do: acc ++ [x], else: acc)}
    end)
    |> elem(1)
  end

  def each(enumerable, function) do
    Enumerable.reduce(enumerable, {:cont, []}, fn x, _ ->
      function.(x)
      {:cont, nil}
    end)
    |> elem(1)
  end
end
