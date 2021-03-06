# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :safeboda,
  ecto_repos: [Safeboda.Repo]

# Configures the endpoint
config :safeboda, SafebodaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "q0olZIQ9Sxj/i7IWLRMaOpj9g1zsNo4QkE2RtrzT1neguLDDvDuWl1RhJdwQbqAF",
  render_errors: [view: SafebodaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Safeboda.PubSub,
  live_view: [signing_salt: "XDi15NGv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# basic auth
config :safeboda, :basic_auth, username: "admin@safeboda.com", password: "secret"

# Guardian
config :safeboda, SafebodaWeb.Auth.Guardian,
  issuer: "safeboda",
  secret_key: "yRERYFwlwdEDqOJWHVb5k6EdXy9Qze9yMJ+08I7pm7qSpjX1lcNw9ynhKyiXCmg0"
