defmodule OperatorsTest do
  use ExUnit.Case
  doctest Operators

  import Kernel, except: [+: 2]
  import Operators

  test "plus operator override" do
    assert "Hello" + " World" == "Hello World"
  end
end
