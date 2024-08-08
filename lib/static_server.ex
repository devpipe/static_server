defmodule StaticServer do
  @moduledoc """
  StaticServer is the main application module that starts the supervisor.
  """

  use Application

  @doc """
  Starts the application and its supervision tree.
  """
  def start(_type, _args) do
    StaticServer.Supervisor.start_link([])
  end
end
