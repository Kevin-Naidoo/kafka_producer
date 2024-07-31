defmodule KafkaCluster.MessagingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KafkaCluster.Messaging` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        key: "some key",
        times: 42,
        topic: "some topic",
        value: "some value"
      })
      |> KafkaCluster.Messaging.create_message()

    message
  end
end
