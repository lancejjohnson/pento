defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Survey.Rating

  schema "products" do
    field(:description, :string)
    field(:name, :string)
    field(:sku, :integer)
    field(:unit_price, :float)
    field(:image_upload, :string)

    timestamps()

    has_many(:ratings, Rating)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0)
  end

  def change_unit_price(%{unit_price: original_unit_price} = product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_required([:unit_price])
    # TODO: This is wrong! This function should either be named in a way that implies less than or it should not validate that the new price is less than the original price
    |> validate_number(:unit_price, less_than: original_unit_price)
  end
end
