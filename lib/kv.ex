defmodule KV do
  def start_link do
    {:ok, spawn_link(fn -> loop(%{}) end)}
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)

      {:put, key, value} ->
        loop(Map.put(map, key, value))

      _ -> loop(map)
    end
  end
end
