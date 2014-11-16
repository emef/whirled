defmodule World.Registry do
  use GenServer

  @doc """
  World registry state.

  `worlds` - HashDict mapping world_id to world worker pid.
  `workers` - World.Worker.Supervisor pid.
  """
  defmodule State do defstruct \
    workers: nil,
    worlds: nil
  end

  # Client API

  @doc "Start a World Registry."
  def start_link(workers, opts \\ []) do
    init_args = {workers}
    GenServer.start_link(__MODULE__, init_args, opts)
  end

  @doc """
  Lookup a world with id = `world_id`.

  Returns `{:ok, pid}` if world exists, otherwise :error
  """
  def lookup(server, world_id) do
    GenServer.call(server, {:lookup, world_id})
  end

  @doc """
  Create a new world.

  Returns `{:ok, pid, world_id}`
  """
  def create(server) do
    GenServer.call(server, :create)
  end

  @doc "Dump the current server state."
  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  # Server callbacks

  @doc "Initialize server state."
  def init({workers}) do
    state = %State{workers: workers, worlds: HashDict.new}
    {:ok, state}
  end

  @doc "Dumps current server state"
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  @doc "Lookup a world"
  def handle_call({:lookup, world_id}, _from, state) do
    case HashDict.get(state.worlds, world_id) do
      nil -> {:reply, :error, state}
      x -> {:reply, {:ok, x}, state}
    end
  end

  @doc "Create a brand new world"
  def handle_call(:create, _from, state) do
    {:ok, pid} = World.Worker.Supervisor.start_world(state.workers)
    world_id = UUID.uuid4()
    worlds = HashDict.put(state.worlds, world_id, pid)
    state = %{state | worlds: worlds}
    {:reply, {:ok, pid, world_id}, state}
  end

end
