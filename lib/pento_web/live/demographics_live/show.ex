defmodule PentoWeb.DemographicsLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  import Phoenix.LiveView, only: [put_flash: 3]

  alias Pento.Survey.Demographics
  alias PentoWeb.CoreComponents

  attr :demographics, Demographics, required: true

  def details(assigns) do
    ~H"""
    <div>
      <h2 class="font-medium text-2xl">
        Demographics <%= raw("&#x2713;") %>
      </h2>
      <CoreComponents.table id={"demographics-#{@demographics.id}"} rows={[@demographics]}>
        <:col :let={demographics} label="Gender">
          <%= demographics.gender %>
        </:col>
        <:col :let={demographics} label="Year of birth">
          <%= demographics.year_of_birth %>
        </:col>
      </CoreComponents.table>
    </div>
    """
  end
end
