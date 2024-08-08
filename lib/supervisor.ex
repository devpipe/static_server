defmodule StaticServer.Supervisor do
  @moduledoc """
  StaticServer.Supervisor is responsible for starting and supervising the
  server.
  """

  use Supervisor
  require Logger

  @doc """
  Starts the supervisor.
  """
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc """
  Initializes the supervision tree.
  """
  def init(_opts) do
    server_config = Application.get_env(:static_server, :server, [serve_from: "priv/static", port: 4001, env: :prod])
    port = Keyword.get(server_config, :port, 4001)
    serve_from = Keyword.get(server_config, :serve_from, "priv/static")

    Logger.info("Starting static server on port #{port}, serving from #{serve_from}")

    children = [
      {Plug.Cowboy, scheme: :http, plug: StaticServer.Router, options: [port: port]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
