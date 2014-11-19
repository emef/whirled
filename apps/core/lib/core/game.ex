defmodule Core.Game do
  use GenServer

  def start_link(game_id, opts \\ []) do
    GenServer.start_link(__MODULE__, game_id, opts)
  end

  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  def step(server) do
    GenServer.call(server, :step)
  end

  # Server callbacks

  def init(game_id) do
    {:ok, random_state(game_id)}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:step, _from, state) do
    state = step_state(state)
    {:reply, state, state}
  end

  # private

  defp step_state(state) do
    characters = state.characters |> Enum.map(fn(char) ->
      loc = Core.World.next_loc(state.world, char.location, char.intention)
      intention = \
        if loc == char.intention do
          Core.World.random_loc(state.world)
        else
          char.intention
        end

      %{char | location: loc, intention: intention}
    end)

    %{state | characters: characters}
  end

  defp random_state(game_id) do
    world = Core.World.random
    characters = 1..100 |> Enum.map(fn(i) -> Core.Char.random(i, world) end)
    %{game_id: game_id, world: world, characters: characters}
  end

end
