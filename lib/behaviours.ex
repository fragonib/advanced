defmodule Tracer do

  defmacro deft({:when, _ , [{name, _, args}, _condition]} = definition, do: body) do
    quote do
      Kernel.def unquote(definition) do
        IO.puts("[Macro Tracer] ==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(body)
        IO.puts("[Macro Tracer] <== result: #{result}")
        result
      end
    end
  end

  defmacro deft({name, _, args} = definition, do: body) do
    quote do
      Kernel.def unquote(definition) do
        IO.puts("[Macro Tracer] ==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(body)
        IO.puts("[Macro Tracer] <== result: #{result}")
        result
      end
    end
  end

  def trace(name, args, body) do
    IO.puts("[Macro Tracer] ==> call: #{Tracer.dump_defn(name, args)}")
    result = Code.eval_quoted(body)
    IO.puts("[Macro Tracer] <== result: #{result}")
    result
  end

  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end
end
