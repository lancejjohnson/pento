defmodule Pento.SurveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Survey` context.
  """

  import Pento.{AccountsFixtures, CatalogFixtures}

  @doc """
  Generate a demographics.
  """
  def demographics_fixture(attrs \\ %{}) do
    user_id = Map.get(attrs, :user_id, user_fixture().id)

    {:ok, demographics} =
      attrs
      |> Enum.into(%{
        gender: "female",
        year_of_birth: 2000,
        user_id: user_id
      })
      |> Pento.Survey.create_demographics()

    demographics
  end

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    user_id = Map.get(attrs, :user_id)
    product_id = Map.get(attrs, :product_id)

    {:ok, rating} =
      attrs
      |> Enum.into(%{
        stars: 4,
        user_id: user_id || user_fixture().id,
        product_id: product_id || product_fixture().id
      })
      |> Pento.Survey.create_rating()

    rating
  end
end
