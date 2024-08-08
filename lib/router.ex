defmodule StaticServer.Router do
  @moduledoc """
  StaticServer.Router handles incoming HTTP requests and serves static files.
  """

  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  @mime_types %{
    ".html" => "text/html",
    ".css" => "text/css",
    ".js" => "application/javascript",
    ".png" => "image/png",
    ".jpg" => "image/jpeg",
    ".jpeg" => "image/jpeg",
    ".gif" => "image/gif",
    ".svg" => "image/svg+xml",
    ".ico" => "image/x-icon",
    ".json" => "application/json",
    ".txt" => "text/plain",
    ".mp4" => "video/mp4",
    ".webm" => "video/webm"
  }

  plug :log_request

  defp log_request(conn, _opts) do
    if Keyword.get(Application.get_env(:static_server, :server), :env) == :debug do
      Logger.debug("Request: #{conn.method} #{conn.request_path}")
    end
    conn
  end

  get "/*path" do
    server_config = Application.get_env(:static_server, :server, [serve_from: "priv/static", port: 4001, env: :prod])
    directory = Keyword.get(server_config, :serve_from, "priv/static")
    file_path = Path.join([directory | path])

    # If path is a directory, look for index.html
    file_path = if File.dir?(file_path) do
      Path.join(file_path, "index.html")
    else
      file_path
    end

    if File.exists?(file_path) do
      mime = @mime_types[Path.extname(file_path)] || "application/octet-stream"
      conn
      |> put_resp_content_type(mime)
      |> send_file(200, file_path)
    else
      conn
      |> put_resp_content_type("text/plain")
      |> send_resp(404, "404 Not Found")
    end
  end

  match _ do
    send_resp(conn, 404, "404 Not Found")
  end
end
