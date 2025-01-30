defmodule TodoApiWeb.Mutations.TodoMutations do
  use Absinthe.Schema.Notation

  alias TodoApiWeb.Resolvers.TodoResolver

  object :todo_mutations do
    field :create_todo, :todo do
      arg(:todo, non_null(:todo_input))
      resolve(&TodoResolver.create_todo/3)
    end

    field :update_todo, :todo_payload do
      arg :id, non_null(:id)
      arg :todo, :todo_input
      resolve &TodoResolver.update_todo/3
    end

    field :delete_todo, :todo_payload do
      arg :id, non_null(:id)
      resolve &TodoResolver.delete_todo/3
    end
  end
end
