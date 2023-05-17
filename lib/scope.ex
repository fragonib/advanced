defmodule Scope do
  defmacro update_local(val) do
    local = "some value"

    result =
      quote do
        local = unquote(val)
        IO.puts("[Macro Scope] End of macro body, local = #{local}")
      end

    IO.puts("[Macro Scope] In macro definition, local = #{local}")
    result
  end
end
