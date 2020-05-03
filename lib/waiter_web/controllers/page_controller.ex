defmodule WaiterWeb.PageController do
  use WaiterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def test_code(conn, _params) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(201, "")
  end

  def show(conn, %{"messenger" => messenger} = params) do
    conn
    |> put_layout("admin.html")
    |> render("show.html", messenger: messenger)
  end

  def del_session(conn, _params) do
    conn = delete_session(conn, :restaurant)
    redirect(conn, to: Routes.page_path(conn, :index))
  end

  def verify(%Plug.Conn{method: "POST"} = conn, params) do
    code = params["code"]
    if code == "12345" do
      conn |> put_session(:restaurant, true)
      |> redirect(to: Routes.page_path(conn, :index)) |> halt()
    else
      conn |> put_flash(:info, "Wrong code entered!")
      |> redirect(to: Routes.page_path(conn, :verify)) |> halt()
    end
    IO.puts """
    POST
    #{inspect(conn)}
    """
    render(conn, "verify_form.html")
  end

  def verify(conn, _params) do
    IO.puts """
    Connection
    #{inspect(conn.method)}
    """
    render(conn, "verify_form.html")
  end

end
