defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def hello(conn, params) do
    number = params["number"] |> String.trim() |> String.to_integer()
    output = Hello.double(number)
    json(conn, %{foo: output})
  end

  def push(conn, params) do
    key = params["key"] |> String.trim()
    value = params["value"] |> String.trim()
    {:ok, result} = Hello.push(key, value)
    json(conn, result)
  end
end
