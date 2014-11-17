defmodule Core.World do
  defstruct [:bounds]

  def next_loc(world, {x0, y0}, {x1, y1}) do
    {towards(x0, x1), towards(y0, y1)}
  end

  def random do
    bounds = {5 + :random.uniform(15), 5 + :random.uniform(15)}
    %Core.World{bounds: bounds}
  end

  def random_loc(world) do
    {x, y} = world.bounds
    {:random.uniform(x), :random.uniform(y)}
  end

  defp towards(x0, x1) do
    cond do
      x0 < x1 -> x0 + 1
      x0 > x1 -> x0 - 1
      x0 == x1 -> x0
    end
  end

end
