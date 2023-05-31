defmodule Tracer do

  defmacro deft({:when, _ , [{name, _, args} = definition, condition]}, do: content) do
    quote do
      Kernel.def unquote(definition) when unquote(condition) do
        IO.puts("[Macro Tracer] ==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(content)
        IO.puts("[Macro Tracer] <== result: #{result}")
        result
      end
    end
  end

  defmacro deft({name, _, args} = definition, do: content) do
    IO.inspect(definition)
    quote do
      Kernel.def unquote(definition) do
        IO.puts("[Macro Tracer] ==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(content)
        IO.puts("[Macro Tracer] <== result: #{result}")
        result
      end
    end
  end

  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  @spec dump_defn(any, any) :: <<_::16, _::_*8>>
  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end
end
