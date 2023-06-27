defmodule Pento.Survey.Demographics.Query do
  import Ecto.Query
  alias Pento.Survey.Demographics

  def base do
    Demographics
  end

  def for_user(query \\ base(), user) do
    query
    |> where([d], d.user_id == ^user.id)
  end
end
