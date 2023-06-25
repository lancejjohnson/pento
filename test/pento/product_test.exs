defmodule Pento.ProductTest do
  use Pento.DataCase
  alias Pento.Catalog.Product

  @valid_attrs %{
    name: "Product",
    description: "Product description",
    sku: "12345",
    unit_price: 0.01
  }

  test "unit price must be greater than zero" do
    attrs = Map.put(@valid_attrs, :unit_price, -0.01)

    cset = Product.changeset(%Product{}, attrs)

    assert %{valid?: false} = cset
    assert "must be greater than 0" in errors_on(cset).unit_price
  end
end
