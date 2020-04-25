defmodule WaiterWeb.Plugs.Session do
  import Plug.Conn


  def init(default), do: default

  def call(conn, _opts) do
    IO.puts """
    Test! Test! Test!
    Conn: #{inspect(conn)}
    Session!!!
    #{inspect(get_session(conn))}
    """
    conn
  end

  def call(conn, default) do
  end
end
