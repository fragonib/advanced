defimpl Collectable, for: Midi do
  def into(%Midi{content: content}) do
    {
      content,
      fn
        acc, {:cont, frame = %Midi.Frame{}} ->
          acc <> Midi.Frame.to_binary(frame)

        acc, :done ->
          %Midi{content: acc}

        _, :halt ->
          :ok
      end
    }
  end
end
