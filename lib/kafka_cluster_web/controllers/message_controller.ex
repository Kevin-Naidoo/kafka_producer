defmodule KafkaClusterWeb.MessageController do
  use KafkaClusterWeb, :controller

  alias KafkaCluster.Messaging
  alias KafkaCluster.Messaging.Message
  alias KafkaCluster.Kaffe.Producer

  def index(conn, _params) do
    messages = Messaging.list_messages()
    render(conn, :index, messages: messages)
  end

  def new(conn, _params) do
    changeset = Messaging.change_message(%Message{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    case Messaging.create_message(message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: ~p"/messages/#{message}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Messaging.get_message!(id)
    render(conn, :show, message: message)
  end

  def edit(conn, %{"id" => id}) do
    message = Messaging.get_message!(id)
    changeset = Messaging.change_message(message)
    render(conn, :edit, message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Messaging.get_message!(id)

    case Messaging.update_message(message, message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message updated successfully.")
        |> redirect(to: ~p"/messages/#{message}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Messaging.get_message!(id)
    {:ok, _message} = Messaging.delete_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: ~p"/messages")
  end

  def send_message(conn, %{"key" => key, "value" => value, "topic" => topic, "times" => times}) do
    # Parse the times parameter, default to 1 if not provided or parsing fails
    times = case Integer.parse(times) do
      {parsed_times, ""} -> parsed_times
      _ -> 1
    end

    # Call the function and handle the response
    case KafkaCluster.Kaffe.Producer.send_my_message({key, value}, topic, times) do
      :ok -> json(conn, %{status: "Messages sent"})
      :error -> json(conn, %{status: "Failed to send messages"})
    end
  end

end
