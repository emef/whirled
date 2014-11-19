defmodule Frontend.Channels.Games do
  use Phoenix.Channel

  def join(socket, topic, message) do
    reply socket, "state", GameApi.get_state(topic)
    {:ok, socket}
  end

  def event(socket, topic, message) do
    reply socket, "state", GameApi.step(topic)
    socket
  end
end
