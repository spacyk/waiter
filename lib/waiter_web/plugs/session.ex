defmodule WaiterWeb.Plugs.Session do
  import Plug.Conn


  def init(default), do: default

  def call(conn, _opts) do
    session = get_session(conn)
    IO.puts """
    Session!!!
    #{inspect(session)}
    """
    x = session['test']
    conn
  end

  def call(conn, default) do
  end
end
