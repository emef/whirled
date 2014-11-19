defmodule Frontend.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/ws"

  scope "/" do
    # Use the default browser stack.
    pipe_through :browser

    get "/", Frontend.PageController, :index, as: :pages
  end

  channel "games", Frontend.Channels.Games

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
