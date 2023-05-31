defmodule Tracer do
  defmacro def_t({:when, _, [{name, _, args}, _condition]} = definition, do: body) do
    build_trace_do(definition, name, args, body)
  end

  defmacro def_t({name, _, args} = definition, do: body) do
    build_trace_do(definition, name, args, body)
  end

  defp build_trace_do(definition, name, args, body) do
    quote do
      Kernel.def unquote(definition) do
        IO.puts("[Macro Tracer] ==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(body)
        IO.puts("[Macro Tracer] <== result: #{result}")
        result
      end
    end
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defp dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end
end
