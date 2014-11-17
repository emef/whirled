defmodule Core.GameServer do
  use GenServer

  defmodule State do defstruct \
    game_sup: nil,
    games: nil
  end

  # Public API

  def start_link(game_sup, opts \\ []) do
    GenServer.start_link(__MODULE__, {game_sup}, opts)
  end

  def get(server, game_id) do
    GenServer.call(server, {:get, game_id})
  end

  def step(server, game_id) do
    GenServer.call(server, {:step, game_id})
  end

  def get_state(server, game_id) do
    GenServer.call(server, {:get_state, game_id})
  end


  # Server callbacks

  def init({game_sup}) do
    init_state = %State{game_sup: game_sup, games: HashDict.new}
    {:ok, init_state}
  end

  def handle_call({:get, game_id}, _from, state) do
    {pid, state} = lookup(game_id, state)
    {:reply, pid, state}
  end

  def handle_call({:step, game_id}, _from, state) do
    {pid, state} = lookup(game_id, state)
    {:reply, Core.Game.step(pid), state}
  end

  def handle_call({:get_state, game_id}, _from, state) do
    {pid, state} = lookup(game_id, state)
    {:reply, Core.Game.get_state(pid), state}
  end

  # Private utilities

  defp lookup(game_id, state) do
    {pid, state} = case HashDict.get(state.games, game_id) do
      nil -> load_or_create(game_id, state)
      pid ->
        if Process.alive?(pid) do
          IO.puts "alive process"
          {pid, state}
        else
          IO.puts "dead process"
          load_or_create(game_id, state)
        end
    end

    {pid, state}
  end

  defp load_or_create(game_id, state) do
    {:ok, pid} = Core.GameSupervisor.start_game(state.game_sup, game_id)
    {pid, %{state | games: HashDict.put(state.games, game_id, pid)}}
  end

end
