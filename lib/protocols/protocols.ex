##
## MyInspect
##

defprotocol MyInspect do
  @fallback_to_any true
  def inspect(thing, opts)
end

defimpl MyInspect, for: PID do
  def inspect(pid, _opts) do
    "#PID" <> IO.iodata_to_binary(:erlang.pid_to_list(pid))
  end
end

defimpl MyInspect, for: Reference do
  def inspect(ref, _opts) do
    '#Ref' ++ rest = :erlang.ref_to_list(ref)
    "#Reference" <> IO.iodata_to_binary(rest)
  end
end

##
## CaesarCypher
##

defprotocol CaesarCypher do
  @fallback_to_any true
  def encrypt(value, shift)
  def rot13(value)
end

defimpl CaesarCypher, for: BitString do
  def encrypt(string, shift) do
    String.to_charlist(string)
      |> Enum.map(&CaesarCypher.encrypt(&1, shift))
      |> Kernel.to_string()
  end
  def rot13(string) do
    CaesarCypher.encrypt(string, 13)
  end
end

defimpl CaesarCypher, for: Integer do
  def encrypt(int, shift) when ?a <= int and int <= ?z do
    ?a + rem(int - ?a + shift, ?z - ?a + 1)
  end
  def encrypt(int, shift) when ?A <= int and int <= ?Z do
    ?A + rem(int - ?A + shift, ?Z - ?A + 1)
  end
  def encrypt(int, _shift), do: int
  def rot13(int) do
    CaesarCypher.encrypt(int, 13)
  end
end

defimpl CaesarCypher, for: List do
  def encrypt(list, shift) do
    Enum.map(list, &CaesarCypher.encrypt(&1, shift))
  end
  def rot13(list) do
    CaesarCypher.encrypt(list, 13)
  end
end

##
## Language Word List + Rot13
##
defmodule Word13 do
  def word13(list) do
    targets = MapSet.new(list)
    Enum.filter(list, &MapSet.member?(targets, CaesarCypher.rot13(&1)))
  end
end
