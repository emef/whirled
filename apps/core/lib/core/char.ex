defmodule Core.Char do
  def random(id, world) do
    location = Core.World.random_loc(world)
    intention = Core.World.random_loc(world)
    %{char_id: id,
      location: location,
      intention: intention}
  end

end
