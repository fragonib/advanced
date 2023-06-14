defmodule MidiTest do
  use ExUnit.Case

  test "enumerable protocol" do
    midi = Midi.from_file("test/midi/rap.mid")
    frames_list = Enum.take(midi, 2)
    assert length(frames_list) == 2
  end

  test "collectable protocol" do
    midi = Midi.from_file("test/midi/rap.mid")
    new_midi = Enum.into(midi, %Midi{})
    assert new_midi == midi
  end

  test "collectable protocol aggregates frames" do
    midi = Midi.from_file("test/midi/rap.mid")
    midi2 = %Midi{}
    midi2 = Enum.take(midi, 1) |> Enum.into(midi2)
    midi2 = [Enum.at(midi, 3)] |> Enum.into(midi2)
    assert Enum.count(midi2) == 2
  end
end
