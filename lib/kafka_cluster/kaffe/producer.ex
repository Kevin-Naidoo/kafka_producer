defmodule KafkaCluster.Kaffe.Producer do
  def send_my_message({key, value}, topic) do
    Kaffe.Producer.produce_sync(topic, [{key, value}])
  end

  def send_my_message(key, value) do
    Kaffe.Producer.produce_sync(key, value)
  end

  def send_my_message(value) do
    Kaffe.Producer.produce_sync("sample_key", value)
  end

  # Sending a message with a specific key and value, using a default topic
  def send_my_message(key, value) do
    default_topic = "my-topic"
    Producer.produce_async(default_topic, [{key, value}])
  end
end
