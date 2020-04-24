defmodule Waiter.Repo do
  use Ecto.Repo,
    otp_app: :waiter,
    adapter: Ecto.Adapters.Postgres
end
