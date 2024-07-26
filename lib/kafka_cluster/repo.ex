defmodule KafkaCluster.Repo do
  use Ecto.Repo,
    otp_app: :kafka_cluster,
    adapter: Ecto.Adapters.Postgres
end
