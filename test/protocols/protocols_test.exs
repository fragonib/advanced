defmodule CaesarCypherTest do
  use ExUnit.Case

  test "caesar encrypt" do
    assert CaesarCypher.encrypt(?5, 2) == ?5
    assert CaesarCypher.encrypt(?\s, 2) == ?\s
    assert CaesarCypher.encrypt(?a, 2) == ?c
    assert CaesarCypher.encrypt(?z, 2) == ?b
    assert CaesarCypher.encrypt(?A, 2) == ?C
    assert CaesarCypher.encrypt(?Z, 2) == ?B
    assert CaesarCypher.encrypt("ABCD 1", 2) == "CDEF 1"
  end

  test "caesar rot13" do
    assert CaesarCypher.rot13("Hello world 12345") == "Uryyb jbeyq 12345"
  end

  test "word13" do
    assert Word13.word13(["casa"]) == []
    assert Word13.word13(["casa", "pnfn", "perro"]) == ["casa", "pnfn"]
  end
end

defmodule MyEnumerableTest do
  use ExUnit.Case
  import Protocols.MyEnumerable

  test "customized enumerable map" do
    assert map([1, 2, 3], fn x -> x * 2 end) == [2, 4, 6]
  end

  test "customized enumerable filter" do
    assert filter([1, 2, 3], fn x -> rem(x, 2) == 1 end) == [1, 3]
  end

  test "customized enumerable each" do
    each([1, 2, 3, 4], fn x -> IO.puts(x) end)
  end
end
