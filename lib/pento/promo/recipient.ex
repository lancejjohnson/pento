defmodule Pento.Promo.Recipient do
  defstruct [:first_name, :email]
  @types %{first_name: :string, email: :string}

  import Ecto.Changeset

  def changeset(%__MODULE__{} = struct, attrs) do
    {struct, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required(Map.keys(@types))
    |> validate_format(:email, ~r/@/)
  end
end
