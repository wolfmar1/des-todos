defmodule DesTodo.ToDos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :date, :naive_datetime
    field :done, :boolean, default: false
    field :due, :date
    field :theme, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:date, :theme, :due, :done])
    |> validate_required([:date, :theme, :due, :done])
  end
end
