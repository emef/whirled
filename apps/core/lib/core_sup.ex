defmodule CoreSupervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @game_sup Core.GameSupervisor
  @game_serv Core.GameServer

  def init(:ok) do
    children = [
      supervisor(Core.GameSupervisor, [[name: @game_sup]]),
      worker(Core.GameServer, [@game_sup, [name: @game_serv]])
    ]

    supervise(children, strategy: :one_for_one)
  end

end
