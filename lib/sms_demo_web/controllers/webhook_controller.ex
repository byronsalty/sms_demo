defmodule SmsDemoWeb.WebhookController do
  alias SmsDemo.SmsHandler
  use SmsDemoWeb, :controller

  def hook(conn, params) do
    SmsHandler.receive_message(params["fromNumber"], params["text"])

    json(conn, %{status: "ok"})
  end
end



# {
#   "fromNumber": "+1555123456",
#   "text": "Here is my reply"
# }
