defmodule Bindings do
  # This macro given a name, defines a function with that name that return its name
  defmacro define(name) do
    quote do
      def unquote(name)(), do: unquote(name)
    end
  end

  # 'bind_quoted' defers execution of 'unquote' enabling using this macro
  # not in compiletime but in runtime
  defmacro define_binding(name) do
    quote bind_quoted: [bound_name: name] do
      def unquote(bound_name)(), do: unquote(bound_name)
    end
  end
end
