import Config

config :static_server, server: [
  serve_from: "public",
  port: 8000,
  env: :debug
]
