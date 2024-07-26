defmodule KafkaCluster.GroupSubscriberV2 do
  @behaviour :brod_group_subscriber_v2
  def init(_arg, _arg2) do
    {:ok, []}
  end

  def handle_message(message, state) do
    IO.inspect(message, label: "message")
    {:ok, :commit, []}
  end
end
