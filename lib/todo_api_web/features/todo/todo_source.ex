defmodule TodoApiWeb.Features.Todo.TodoSource do
  import Ecto.Query

  def data() do
    Dataloader.Ecto.new(TodoApi.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
