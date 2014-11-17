defmodule Core.Char do
  defstruct [:char_id, :location, :intention]

  def random(id, world) do
    location = Core.World.random_loc(world)
    intention = Core.World.random_loc(world)
    %Core.Char{
      char_id: id,
      location: location,
      intention: intention}
  end

end
