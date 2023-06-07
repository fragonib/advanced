defmodule BindingTest do
  use ExUnit.Case
  doctest Bindings

  test "no binding needed" do
    assert Test.some_name() == :some_name
  end

  test "binding needed" do
    assert Test.fred() == :fred
    assert Test.bert() == :bert
  end
end

defmodule Test do
  require Bindings, as: B
  B.define(:some_name)
  [:fred, :bert] |> Enum.each(&B.define_binding(&1))
end
