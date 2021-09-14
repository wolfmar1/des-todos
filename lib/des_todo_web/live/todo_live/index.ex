defmodule DesTodoWeb.TodoLive.Index do
  use DesTodoWeb, :live_view

  alias DesTodo.ToDos
  alias DesTodo.ToDos.Todo

  @impl true
  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _session, socket) do
    hide_done = true
    socket = assign(socket, :hide_done, hide_done)
    {:ok, assign(socket, :todos, fetch_todos(hide_done))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Todo")
    |> assign(:todo, ToDos.get_todo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Todo")
    |> assign(:todo, %Todo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Todos")
    |> assign(:todo, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo = ToDos.get_todo!(id)
    {:ok, _} = ToDos.delete_todo(todo)

    {:noreply, assign(socket, :todos, fetch_todos(false))}
  end

  def handle_event("filter", %{"filter" => %{"filter" => params}}, socket) do
    hide_done = params == "true"
    socket = assign(socket, hide_done: hide_done, todos: fetch_todos(hide_done))

    {:noreply, socket}
  end

  defp fetch_todos(hide_done) do
    todos = ToDos.list_todos()
    if hide_done do
      Enum.filter(todos, &(!&1.done))
    else
      todos
    end

  end
end
