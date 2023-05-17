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
end
