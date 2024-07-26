defmodule KafkaCluster.CallGroupSubscriber do

  def callback do
    group_config = [
      offset_commit_policy: :commit_to_kafka_v2,
      offset_commit_interval_seconds: 5,
      rejoin_delay_seconds: 2,
      reconnect_cool_down_seconds: 10
    ]

    config = %{
      client: :kafka_client,
      group_id: "consumer_group",
      topics: ["my-topic"],
      cb_module: KafkaCluster.GroupSubscriberV2,
      group_config: group_config,
      consumer_config: [begin_offset: :earliest]
    }

    {:ok, pid} = :brod.start_link_group_subscriber_v2(config)
  end
end
