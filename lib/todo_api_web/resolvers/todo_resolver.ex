defmodule TodoApiWeb.Resolvers.TodoResolver do
  alias TodoApi.Todos

  def list_todos(_parent, _args, _resolution) do
    {:ok, Todos.list_todos()}
  end

  @spec get_todo(any(), %{:id => any(), optional(any()) => any()}, any()) ::
          {:error, <<_::112>>} | {:ok, any()}
  def get_todo(_parent, %{id: id}, _resolution) do
    case Todos.get_todo(id) do
      nil -> {:error, "Todo not found"}
      todo -> {:ok, todo}
    end
  end

  def create_todo(_parent, %{todo: todo_params}, _resolution) do
    Todos.create_todo(todo_params)
  end

  def update_todo(_parent, %{id: id, todo: todo_params}, _resolution) do
    case Todos.get_todo(id) do
      nil ->
        {:error, "Todo not found"}

      todo ->
        case Todos.update_todo(todo, todo_params) do
          {:ok, updated_todo, message} ->
            {:ok, %{todo: updated_todo, message: message}}

          {:error, _changeset} ->
            {:error, "Could not update todo"}
        end
    end
  end

  def delete_todo(_parent, %{id: id}, _resolution) do
    case Todos.get_todo(id) do
      nil ->
        {:ok, %{
          todo: nil,
          message: "Failed to delete todo",
          errors: [%{key: "not_found", message: "Todo with ID #{id} not found"}]
        }}

      todo ->
        case Todos.delete_todo(todo) do
          {:ok, deleted_todo, message} ->
            {:ok, %{
              todo: deleted_todo,
              message: message,
              errors: []
            }}

          {:error, _changeset} ->
            {:ok, %{
              todo: nil,
              message: "Failed to delete todo",
              errors: [%{key: "delete_failed", message: "Could not delete todo"}]
            }}
        end
    end
  end
end
