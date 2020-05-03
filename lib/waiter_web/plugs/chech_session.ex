defmodule WaiterWeb.Plugs.CheckSession do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  alias WaiterWeb.Router.Helpers, as: Routes
  

  def init(default), do: default

  def call(conn, _opts) do
    if get_session(conn, "restaurant") == true do
      conn
    else

      conn |> put_flash(:info, "You can't access that page")
      |> redirect(to: Routes.page_path(conn, :verify)) |> halt()
    end
  end

end
