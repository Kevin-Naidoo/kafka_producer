defmodule KafkaCluster.Kaffe.Producer do
  # def send_my_message({key, value}, topic) do
  #   Kaffe.Producer.produce_sync(topic, [{key, value}])
  # end
  require Logger

  def send_my_message({key, value}, topic, times \\ 1) when is_integer(times) and times > 0 do
    start_time = :os.system_time(:millisecond)

    Enum.each(1..times, fn _ ->
      Kaffe.Producer.produce_sync(topic, [{key, value}])
    end)

    end_time = :os.system_time(:millisecond)
    duration = end_time - start_time

    Logger.info("Sent #{times} messages to topic #{topic} in #{duration} ms")
  end


  # def send_my_message(key, value) do
  #   Kaffe.Producer.produce_sync(key, value)
  # end

  # def send_my_message(value) do
  #   Kaffe.Producer.produce_sync("sample_key", value)
  # end

end
