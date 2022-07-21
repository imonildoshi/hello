defmodule Hello.Publisher do
  @moduledoc false
  @behaviour GenRMQ.Publisher

  require Logger

  def init do
    [
      exchange: System.get_env("RMQ_EXCHANGE"),
      connection: System.get_env("RABBITMQ_URL")
    ]
  end

  def start_link do
    GenRMQ.Publisher.start_link(__MODULE__, name: __MODULE__)
  end

  def publish_message(message, routing_key) do
    Logger.info("Publishing message #{inspect(message)}")
    GenRMQ.Publisher.publish(__MODULE__, message, routing_key)
  end
end
