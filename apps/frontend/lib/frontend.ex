defmodule Frontend do
  use Application

  def start(_type, _args) do
    IO.puts "Running Whirled frontend on http://localhost:4000"
    Plug.Adapters.Cowboy.http FrontendPlug, []
  end

end

defmodule FrontendPlug do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    FrontendRouter.call(conn, FrontendRouter.init([]))
  end
end

defmodule FrontendRouter do
  import Plug.Conn
  use Plug.Router

  plug Plug.Static, at: "/static", from: :frontend

  plug :match
  plug :dispatch

  get "/" do
    send_html(conn, "index2.html")
  end

  get "/state/:game/" do
    state = GameApi.get_state(game)
    {:ok, resp} = JSON.encode(state)
    send_resp(conn, 200, resp)
  end

  get "/step/:game/" do
    {:ok, resp} = JSON.encode(GameApi.step(game))
    IO.puts(resp)
    send_resp(conn, 200, resp)
  end

  get _, do: send_resp(conn, 200, "WHAT")

  defp send_html(conn, filename) do
    conn = put_resp_header(conn, "content-type", "text/html")
    path = Path.join([Application.app_dir(:frontend), "priv/static", filename])
    IO.puts path
    send_file(conn, 200, path)
  end

end
