defmodule KafkaCluster.MessagingTest do
  use KafkaCluster.DataCase

  alias KafkaCluster.Messaging

  describe "messages" do
    alias KafkaCluster.Messaging.Message

    import KafkaCluster.MessagingFixtures

    @invalid_attrs %{value: nil, times: nil, key: nil, topic: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messaging.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messaging.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{value: "some value", times: 42, key: "some key", topic: "some topic"}

      assert {:ok, %Message{} = message} = Messaging.create_message(valid_attrs)
      assert message.value == "some value"
      assert message.times == 42
      assert message.key == "some key"
      assert message.topic == "some topic"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messaging.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{value: "some updated value", times: 43, key: "some updated key", topic: "some updated topic"}

      assert {:ok, %Message{} = message} = Messaging.update_message(message, update_attrs)
      assert message.value == "some updated value"
      assert message.times == 43
      assert message.key == "some updated key"
      assert message.topic == "some updated topic"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messaging.update_message(message, @invalid_attrs)
      assert message == Messaging.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messaging.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messaging.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messaging.change_message(message)
    end
  end
end
