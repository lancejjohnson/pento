defmodule Pento.CatalogTest do
  use Pento.DataCase
  import Pento.{AccountsFixtures, CatalogFixtures, SurveyFixtures}

  alias Pento.Catalog
  alias Pento.Survey.Rating

  describe "products" do
    alias Pento.Catalog.Product

    import Pento.CatalogFixtures

    @invalid_attrs %{description: nil, name: nil, sku: nil, unit_price: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{
        description: "some description",
        name: "some name",
        sku: 42,
        unit_price: 120.5
      }

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.description == "some description"
      assert product.name == "some name"
      assert product.sku == 42
      assert product.unit_price == 120.5
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()

      update_attrs = %{
        description: "some updated description",
        name: "some updated name",
        sku: 43,
        unit_price: 456.7
      }

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.description == "some updated description"
      assert product.name == "some updated name"
      assert product.sku == 43
      assert product.unit_price == 456.7
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end

    test "list_products_with_user_rating/1 returns all products preloading any ratings by the given user" do
      %{id: user_id} = user = user_fixture()
      %{id: otheruser_id} = user_fixture()

      # Create products, some of which are rated by the user
      for n <- 0..3 do
        product = product_fixture()
        # all of the products have been rated by another user
        rating_fixture(%{user_id: otheruser_id, product_id: product.id})

        if n in [1, 2] do
          # Some of the products have been rated by user
          rating_fixture(%{user_id: user_id, product_id: product.id})
        end
      end

      products = Catalog.list_products_with_user_rating(user)

      assert Enum.count(products) == 4
      for product <- products, rating <- product.ratings do
        assert %Rating{user_id: ^user_id} = rating
      end
    end
  end
end
