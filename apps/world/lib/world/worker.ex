defmodule World.Worker do
  use GenServer

  defmodule World_ do defstruct \
    bounds: nil,
    graph: nil
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, %World_{}}
  end

  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

end
