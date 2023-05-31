defmodule BehavipoursTest do
  use ExUnit.Case

  import Kernel
  import Tracer

  def_t sum_three(a, b, c) when a > 0, do: a + b + c

  def_t sum_list(list), do: Enum.reduce(list, 0, &(&1 + &2))

  test "test_def_with_condition" do
    assert sum_three(1, 2, 3) == 6
  end

  test "test_def_without_condition" do
    assert sum_list([1, 2, 3]) == 6
  end
end
