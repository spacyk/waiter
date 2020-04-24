# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :waiter,
  ecto_repos: [Waiter.Repo]

# Configures the endpoint
config :waiter, WaiterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cRBO8gvDzmvCoiXTc8gmbckupX6tsf65MV3NVusWGWVrzfGlMpoJ209TMTXO/Wfm",
  render_errors: [view: WaiterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Waiter.PubSub,
  live_view: [signing_salt: "7nSn0hAP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
