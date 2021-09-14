defmodule DesTodo.Repo do
  use Ecto.Repo,
    otp_app: :des_todo,
    adapter: Ecto.Adapters.MyXQL
end
