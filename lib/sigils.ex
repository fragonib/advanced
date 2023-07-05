defmodule LineSigil do
  @doc """
  Implement the `~l` sigil, which takes a string containing
  multiple lines and returns a list of those lines.
  """
  def sigil_l(lines, _opts) do
    lines |> String.trim_trailing() |> String.split("\n")
  end
end

defmodule ColorSigil do
  @color_map [
    # ...
    rgb: [red: 0xFF0000, green: 0x00FF00, blue: 0x0000FF],
    hsb: [red: {0, 100, 100}, green: {120, 100, 100}, blue: {240, 100, 100}]
  ]
  def sigil_c(color_name, []), do: _c(color_name, :rgb)
  def sigil_c(color_name, 'r'), do: _c(color_name, :rgb)
  def sigil_c(color_name, 'h'), do: _c(color_name, :hsb)

  defp _c(color_name, color_space) do
    @color_map[color_space][String.to_atom(color_name)]
  end

  @doc """
    excludes standard ´c´ sigill provided by default module
    ## Example usage
    use ColorSigil
  """
  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [sigil_c: 2]
      import unquote(__MODULE__), only: [sigil_c: 2]
    end
  end
end

defmodule CsvSigil do
  def sigil_v(lines, 'f') do
    _csv(lines)
    |> Enum.map(&Enum.map(&1, fn x -> parse_float(x) end))
  end

  def sigil_v(lines, 'fh') do
    [head, tail] = String.split(lines, "\n", parts: 2)
    rest = sigil_v(tail, 'f')

    _csv(head)
    |> Enum.concat(rest)
    |> buildRecordWithHeaders()
  end

  def sigil_v(lines, 'hf') do
    sigil_v(lines, 'fh')
  end

  def sigil_v(lines, 'h') do
    _csv(lines)
    |> buildRecordWithHeaders()
  end

  def sigil_v(lines, _) do
    _csv(lines)
  end

  defp _csv(linesExprLiteral) do
    linesExprLiteral
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end

  defp buildRecordWithHeaders([head | tail]) do
    headers = Enum.map(head, &String.to_atom/1)
    tail |> Enum.map(&Enum.zip(headers, &1))
  end

  defp parse_float(x) do
    case Float.parse(x) do
      {float, ""} -> float
      _ -> x
    end
  end
end
