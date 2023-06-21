defmodule SigilsTest do
  use ExUnit.Case
  import LineSigil
  use ColorSigil
  import CsvSigil

  test "lines" do
    assert ~l"""
           line 1
           line 2
           and another line in #{__MODULE__}
           """ == [
             "line 1",
             "line 2",
             "and another line in #{__MODULE__}"
           ]
  end

  test "color sigil with modifier or " do
    assert ~c{red} == 16_711_680
    assert ~c{red}h == {0, 100, 100}
  end

  test "csv sigil" do
    assert ~v"""
           1,2,3
           cat,dog
           """ == [
             ["1", "2", "3"],
             ["cat", "dog"]
           ]
  end

  test "csv sigil with 'f' modifier to parse floats" do
    assert ~v"""
           1,2,3.14
           cat,dog
           """f == [
             [1.0, 2.0, 3.14],
             ["cat", "dog"]
           ]

    assert ~v"""
           1.unparseable_float,2,3.14
           cat,dog
           """f == [
             ["1.unparseable_float", 2.0, 3.14],
             ["cat", "dog"]
           ]
  end

  test "csv sigil with 'h' to include header" do
    assert ~v"""
           Item,Qty,Price
           Teddy bear,4,34.95
           Milk,1,2.99
           Battery,6,8.00
           """h ==
             [
               [Item: "Teddy bear", Qty: "4", Price: "34.95"],
               [Item: "Milk", Qty: "1", Price: "2.99"],
               [Item: "Battery", Qty: "6", Price: "8.00"]
             ]
  end

  test "csv sigil combining modifiers" do
    assert ~v"""
           Item,Qty,Price
           Teddy bear,4,34.95
           Milk,1,2.99
           Battery,6,8.00
           """fh ==
             [
               [Item: "Teddy bear", Qty: 4, Price: 34.95],
               [Item: "Milk", Qty: 1, Price: 2.99],
               [Item: "Battery", Qty: 6, Price: 8.00]
             ]
  end
end
