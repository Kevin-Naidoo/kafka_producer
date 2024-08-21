# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :kafka_cluster,
  ecto_repos: [KafkaCluster.Repo]

# Configures the endpoint
config :kafka_cluster, KafkaClusterWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: KafkaClusterWeb.ErrorHTML, json: KafkaClusterWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: KafkaCluster.PubSub,
  live_view: [signing_salt: "LMqR2+nQ"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :kafka_cluster, KafkaCluster.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

  config :logger,
  backends: [:console, {LoggerFileBackend, :file_log}],
  format: "$time $metadata[$level] $message\n",
  metadata: :all

config :logger, :file_log,
  path: "file.log",
  level: :info # or whatever level you prefer

  config :kaffe,
  producer: [
    # heroku_kafka_env: true,
    endpoints: [{System.get_env("IP", "localhost") |> String.to_charlist , 9092}],
    topics: [System.get_env("CLUSTER_TOPIC")],
    linger_ms: 10,
    batch_size: 1000

    # # optional
    # partition_strategy: :md5
  ]
# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
# config :logger, :console,
#   format: "$time $metadata[$level] $message\n",
#   metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
