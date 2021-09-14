defmodule DesTodo.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :date, :naive_datetime
      add :theme, :string
      add :due, :date
      add :done, :boolean, default: false, null: false

      timestamps()
    end

  end
end
