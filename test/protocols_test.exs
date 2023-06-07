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
