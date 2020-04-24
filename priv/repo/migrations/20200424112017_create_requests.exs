defmodule Waiter.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :table, :string
      add :body, :string

      timestamps()
    end

  end
end
