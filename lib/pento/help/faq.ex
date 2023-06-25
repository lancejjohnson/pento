defmodule Pento.Help.FAQ do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :answer, :string
    field :question, :string
    field :vote_count, :integer

    timestamps()
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer, :vote_count])
    |> validate_required([:question])
  end

  def vote_changeset(faq, attrs) do
    faq |> cast(attrs, [:vote_count])
  end
end
