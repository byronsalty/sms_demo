defmodule SmsDemoWeb.PageController do
  use SmsDemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def start(conn, params) do
    phone = params["phone"]
    message = "Q. Why shouldn't you marry a tennis player?"
    SmsDemo.SmsHandler.send_message(phone, message)

    json(conn, %{status: "ok"})
  end
end
