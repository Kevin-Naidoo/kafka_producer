defmodule KafkaCluster.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :key, :string
      add :value, :string
      add :topic, :string
      add :times, :integer

      timestamps()
    end
  end
end
