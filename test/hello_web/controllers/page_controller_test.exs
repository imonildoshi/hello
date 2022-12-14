defmodule HelloWeb.PageControllerTest do
  use HelloWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "GET /hello", %{conn: conn} do
    conn = get(conn, "/hello?number=4")
    assert json_response(conn, 200)
    assert conn.resp_body =~ "{\"foo\":8}"
  end
end
