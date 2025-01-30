defmodule TodoApiWeb.Types.TodoTypes do
  use Absinthe.Schema.Notation

  object :todo do
    field :id, :id
    field :title, :string
    field :description, :string
    field :completed, :boolean
    field :inserted_at, :string
  end

  input_object :todo_input do
    field :title, non_null(:string)
    field :description, :string
    field :completed, :boolean
  end

  object :todo_payload do
    field :todo, :todo
    field :message, :string
    field :errors, list_of(:error)
  end

  object :error do
    field :key, :string
    field :message, :string
  end
end
