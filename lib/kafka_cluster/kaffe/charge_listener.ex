defmodule KafkaCluster.Kaffe.ChargeListener do

    use GenServer

    require Logger

    def start_link(_) do
      GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end

    def init(_) do
      {:ok, _conn} = Postgrex.Notifications.start_link(name: :notifications, hostname: "localhost",
      username: "postgres",
      password: "123456",
      database: "kafka_cluster_dev")

      Logger.info("Thoma")
      Postgrex.Notifications.listen(:notifications, "new_charge") |> IO.inspect
      {:ok, %{}}
    end

    def handle_info({:notification, _pid, _ref, _channel, payload}, state) do
         # Assuming the payload is a JSON string, you might need to decode it first
         decoded_payload = Jason.decode!(payload)
         IO.puts "Test check"
         IO.inspect decoded_payload


      # MyApp.KafkaProducer.publish("charges_topic", payload)
      KafkaCluster.Kaffe.Producer.send_my_message({"charge_key", decoded_payload}, "kafka-topic-test")

      # KafkaCluster.Kaffe.Producer.send_my_message({"test",message}, "my-topic",250)

      {:noreply, state}
    end

end
