defmodule Core do
  use Application

  @core_sup CoreSupervisor

  def start(_type, _args) do
    :random.seed(:erlang.now)
    CoreSupervisor.start_link([name: @core_sup])
  end
end
