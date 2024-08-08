defmodule Mix.Tasks.Server.Static do
  use Mix.Task

  @shortdoc "Starts the static server"
  def run(_) do
    {:ok, _} = Application.ensure_all_started(:static_server)
    port = Keyword.get(Application.get_env(:static_server, :server), :port)
    IO.puts("Static server started at http://localhost:#{port}")
    :timer.sleep(:infinity)
  end
end
