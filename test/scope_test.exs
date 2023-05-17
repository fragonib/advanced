defmodule ScopeTest do
  require Scope
  local = 123
  Scope.update_local("cat")
  IO.puts("[Macro Scope] On return, local = #{local}")
end
