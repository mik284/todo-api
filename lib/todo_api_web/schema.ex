defmodule TodoApiWeb.Schema do
  use Absinthe.Schema

  alias TodoApiWeb.Features.Todo.TodoSource

  import_types(TodoApiWeb.Types.TodoTypes)
  import_types(TodoApiWeb.Queries.TodoQueries)
  import_types(TodoApiWeb.Mutations.TodoMutations)

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:todos, TodoSource.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    import_fields(:todo_queries)
  end

  mutation do
    import_fields(:todo_mutations)
  end
end
