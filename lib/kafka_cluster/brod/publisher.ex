defmodule KafkaCluster.Brod.Publisher do
  def publish(topic, partition, partition_key, message) do
    :brod.produce_sync(
      :kafka_client,
      topic,
      partition,
      partition_key,
      message
    )
  end
end
