defmodule WaiterWeb.PageHiddenController do
  use WaiterWeb, :controller

  plug :put_view, WaiterWeb.PageView
  plug WaiterWeb.Plugs.CheckSession

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
