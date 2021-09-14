# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :des_todo,
  ecto_repos: [DesTodo.Repo]

# Configures the endpoint
config :des_todo, DesTodoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MZFlHQwMey+9qyvVNdPZ+UNnztJKP3AOS4lTj8ih/3kTWEPhVm8ONmUK27smxmUX",
  render_errors: [view: DesTodoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DesTodo.PubSub,
  live_view: [signing_salt: "v3Gj5IWX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
