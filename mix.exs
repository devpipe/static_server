defmodule StaticServer.MixProject do
  use Mix.Project

  @version "0.0.1"
  @description "Static web server"

  def project do
    [
      app: :static_server,
      version: @version,
      description: @description,
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {StaticServer, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.7.1"},
      {:plug, "~> 1.16"},
      {:tasks, git: "https://github.com/devpipe/mix_tasks.git", branch: "main"},
    ]
  end
end
