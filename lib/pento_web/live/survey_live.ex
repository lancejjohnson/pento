defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias PentoWeb.DemographicsLive
  alias PentoWeb.SurveyLive.Component
  alias PentoWeb.Title
  alias Pento.Survey
  alias PentoWeb.DemographicsLive

  def mount(_params, _session, socket) do
    {:ok, assign_demographics(socket)}
  end

  defp assign_demographics(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographics, Survey.get_demographics_by_user(current_user))
  end

  def handle_info({:created_demographics, demographics}, socket) do
    {:noreply, handle_demographic_created(socket, demographics)}
  end

  defp handle_demographic_created(socket, demographics) do
    socket
    |> put_flash(:info, "Demographics created successfully")
    |> assign(:demographics, demographics)
  end
end
