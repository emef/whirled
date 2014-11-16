defmodule World do
  use Application

  @registry_name World.Registry
  @worker_sup_name World.Worker.Supervisor

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(World.Worker.Supervisor, [[name: @worker_sup_name]]),
      worker(World.Registry, [@worker_sup_name, [name: @registry_name]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: World.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
