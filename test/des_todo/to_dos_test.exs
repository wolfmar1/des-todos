defmodule DesTodo.ToDosTest do
  use DesTodo.DataCase

  alias DesTodo.ToDos

  describe "todos" do
    alias DesTodo.ToDos.Todo

    @valid_attrs %{date: ~N[2010-04-17 14:00:00], done: true, due: ~D[2010-04-17], theme: "some theme"}
    @update_attrs %{date: ~N[2011-05-18 15:01:01], done: false, due: ~D[2011-05-18], theme: "some updated theme"}
    @invalid_attrs %{date: nil, done: nil, due: nil, theme: nil}

    def todo_fixture(attrs \\ %{}) do
      {:ok, todo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ToDos.create_todo()

      todo
    end

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert ToDos.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert ToDos.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      assert {:ok, %Todo{} = todo} = ToDos.create_todo(@valid_attrs)
      assert todo.date == ~N[2010-04-17 14:00:00]
      assert todo.done == true
      assert todo.due == ~D[2010-04-17]
      assert todo.theme == "some theme"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ToDos.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{} = todo} = ToDos.update_todo(todo, @update_attrs)
      assert todo.date == ~N[2011-05-18 15:01:01]
      assert todo.done == false
      assert todo.due == ~D[2011-05-18]
      assert todo.theme == "some updated theme"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = ToDos.update_todo(todo, @invalid_attrs)
      assert todo == ToDos.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = ToDos.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> ToDos.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = ToDos.change_todo(todo)
    end
  end
end
