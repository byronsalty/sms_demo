defmodule SmsDemo.SmsHandler do
  use GenServer

  def send_message(to_phone, message) do
    GenServer.cast(SmsDemo.SmsHandler, {:send, {to_phone, message}})
  end
  def receive_message(from_phone, message) do
    GenServer.cast(SmsDemo.SmsHandler, {:receive, {from_phone, message}})
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, %{}}
  end

  def handle_cast({:send, {phone, message}}, state) do

    textbelt_url = "https://textbelt.com/text"
    textbelt_key = Application.get_env(:sms_demo, :textbelt_key)
    replyWebhookUrl = Application.get_env(:sms_demo, :webhook_url)

    params = %{
      phone: phone,
      message: message,
      key: textbelt_key,
      replyWebhookUrl: replyWebhookUrl
    }

    HTTPoison.post(textbelt_url,
      Poison.encode!(params),
      [{"Content-type", "application/json"}])

    {:noreply, state}
  end

  def handle_cast({:receive, {phone, message}}, state) do

    # TODO: Do something with the message

    if message == "Why?" do
      send_message(phone, "A. Because love means nothing to them.")
    end

    {:noreply, state}
  end
end
