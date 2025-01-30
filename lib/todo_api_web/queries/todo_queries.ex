defmodule TodoApiWeb.Queries.TodoQueries do
  use Absinthe.Schema.Notation

  alias TodoApiWeb.Resolvers.TodoResolver

  object :todo_queries do
    field :todos, list_of(:todo) do
      resolve(&TodoResolver.list_todos/3)
    end

    field :todo, :todo do
      arg :id, non_null(:id)
      resolve &TodoResolver.get_todo/3
    end
  end
end
