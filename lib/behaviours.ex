defmodule Tracer do

  defmacro def({:when, _ , [{name, _, args} = definition, condition]}, do: content) do
    quote do
      Kernel.def unquote(definition) when unquote(condition) do
        IO.puts("==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(content)
        IO.puts("<== result: #{result}")
        result
      end
    end
  end

  defmacro def({name, _, args} = definition, do: content) do
    IO.inspect(definition)
    quote do
      Kernel.def unquote(definition) do
        IO.puts("==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(content)
        IO.puts("<== result: #{result}")
        result
      end
    end
  end

  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end
end

defmodule Test do
  import Kernel, except: [def: 2]
  import Tracer, only: [def: 2]

  def puts_sum_three(a, b, c) do
    IO.inspect(a + b + c)
  end

  def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))

end
