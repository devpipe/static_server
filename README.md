
# Static Server

A simple static web server that can be used standalone or as a library in another application. The server serves static files and includes logging capabilities.

## Features

- Serves static files from a configurable directory.
- Logs requests when the environment is set to `:debug`.
- Can be started standalone using a Mix task.
- Configurable port and directory through a single configuration entry.

## Installation

Add the following dependencies to your `mix.exs`:

```elixir
defp deps do
  [
    {:static_server, "~> 0.0.1"}
  ]
end
```

Then run:

```sh
mix deps.get
```

## Configuration

Configure the server by adding the following to `config/config.exs`:

```elixir
use Mix.Config

config :logger, level: :debug

config :static_server, server: [serve_from: "priv/static", port: 4001, env: :debug]
```

## Usage

### Standalone

You can start the server standalone using the Mix task:

```sh
mix server.static
```

This will start the server and log the URL:

```sh
Static server started at http://localhost:4001
```

### As a Library

To use the static server as a library in another application, include it as a dependency:

```elixir
defp deps do
  [
    {:static_server, "~> 0.0.1"}
  ]
end
```

Start it in the host application's supervision tree:

```elixir
defmodule HostApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      # other children...
      StaticServer.Supervisor
    ]

    opts = [strategy: :one_for_one, name: HostApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```


## Logging

The server logs requests when the environment is set to `:debug`. You can configure this in `config/config.exs`:

```elixir
config :static_server, server: [serve_from: "priv/static", port: 4001, env: :debug]
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
