defmodule KafkaCluster.Messaging.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :value, :string
    field :times, :integer
    field :key, :string
    field :topic, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:key, :value, :topic, :times])
    |> validate_required([:key, :value, :topic, :times])
  end
end
