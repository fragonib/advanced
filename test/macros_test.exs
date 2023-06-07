defmodule MacrosTest do
  use ExUnit.Case
  doctest Macros
  require Macros, as: M

  test "First macro" do
    assert :ok == M.first_macro(:ok)
  end

  test "if" do
    assert :not_match == M.if(1 > 5, do: :match, else: :not_match)
    assert :match == M.if(10 > 5, do: :match, else: :not_match)
  end

  test "unless" do
    assert :not_match == M.unless(1 > 5, do: :not_match)
    assert nil == M.unless(10 > 5, do: :not_match)
  end

  test "times" do
    assert [:ok, :ok, :ok, :ok, :ok] == M.times(5, do: :ok)
  end

  test "explain" do
    assert "2" == M.explain(do: 2)
    assert "add 2 and 3" == M.explain(do: 2 + 3)
    assert "subtract 3 from 2" == M.explain(do: 2 - 3)
    assert "multiply 2 and 3" == M.explain(do: 2 * 3)
    assert "divide 2 by 3" == M.explain(do: 2 / 3)
    assert "multiply 3 and 4, then add 2" == M.explain(do: 2 + 3 * 4)
    assert "multiply 2 and 1, multiply 3 and 4, then add them" == M.explain(do: 2 * 1 + 3 * 4)
    assert "add 1 and 2, then add 3" == M.explain(do: 1 + 2 + 3)
    assert "add 1 and 2, then add 3" == M.explain(do: 1 + 2 + 3)
    assert "add 2 and 3, then add 1" == M.explain(do: 1 + (2 + 3))

    assert "add 2 and 3, then divide 1 by it" == M.explain(do: 1 / (2 + 3))
    assert "add 1 and 2, then divide it by 3" == M.explain(do: (1 + 2) / 3)
    assert "add 1 and 2, add 3 and 4, then divide them" == M.explain(do: (1 + 2) / (3 + 4))

    assert "add 2 and 3, then subtract it from 1" == M.explain(do: 1 - (2 + 3))
    assert "add 1 and 2, then subtract 3 from it" == M.explain(do: 1 + 2 - 3)
    assert "add 1 and 2, add 3 and 4, then subtract them" == M.explain(do: 1 + 2 - (3 + 4))
  end
end
