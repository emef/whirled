defimpl JSON.Encoder, for: Core.Game.State do
  def encode(game) do
    dict = game |> Map.delete(:__struct__) |> Map.to_list
    JSON.Encoder.Helpers.dict_encode(dict)
  end

  def typeof(_), do: :object
end

defimpl JSON.Encoder, for: Core.Char do
  def encode(char) do
    dict = char |> Map.delete(:__struct__) |> Map.to_list
    JSON.Encoder.Helpers.dict_encode(dict)
  end

  def typeof(_), do: :object
end


defimpl JSON.Encoder, for: Core.World do
  def encode(world) do
    dict = world |> Map.delete(:__struct__) |> Map.to_list
    JSON.Encoder.Helpers.dict_encode(dict)
  end

  def typeof(_), do: :object
end
