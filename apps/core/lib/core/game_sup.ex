defmodule Core.GameSupervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def start_game(supervisor, game_id) do
    Supervisor.start_child(supervisor, [game_id])
  end

  def init(:ok) do
    children = [
      worker(Core.Game, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

end
