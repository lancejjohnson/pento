defmodule PentoWeb.DemographicsLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  alias Pento.Survey.Demographics

  attr :demographics, Demographics, required: true
  def details(assigns) do
    ~H"""
    <div>
      <h2 class="font-medium text-2xl">
        Demographics <%= raw("&#x2713;") %>
      </h2>
      <ul>
        <li>Gender: <%= @demographics.gender %></li>
        <li>Year of birth: <%= @demographics.year_of_birth %></li>
      </ul>
    </div>
    """
  end
end
