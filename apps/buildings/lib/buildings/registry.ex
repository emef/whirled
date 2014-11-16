defmodule Buildings.Registry do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, 1}
  end

  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

end
