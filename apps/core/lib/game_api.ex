defmodule GameApi do
  def get_state(game_id) do
    Core.GameServer.get_state(Core.GameServer, game_id)
  end

  def step(game_id) do
    Core.GameServer.step(Core.GameServer, game_id)
  end
end
