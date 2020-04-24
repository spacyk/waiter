defmodule Waiter.Dashboard.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field :body, :string
    field :table, :string, default: "Main Table"

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:table, :body])
    |> validate_required([:table, :body])
    |> validate_length(:body, min: 2, max: 50)
  end
end
