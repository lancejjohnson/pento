defmodule PentoWeb.DemographicsLive.Form do
  use PentoWeb, :live_component
  alias Pento.Survey
  alias Pento.Survey.Demographics

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_demographics()
      |> assign_changeset()
    }
  end

  @impl true
  def handle_event("save", %{"demographics" => demographics_params}, socket) do
    params = params_with_user_id(demographics_params, socket)
    socket = save_demographics(socket, params)
    {:noreply, socket}
  end

  defp save_demographics(socket, params) do
    case Survey.create_demographics(params) do
      {:ok, demographics} ->
        # When we successfully save a demographics, we want to inform the
        # parent process it happened so it can decide what to do. The Form
        # shouldn't care about that responsibility. It just handles the Form
        # not what happens after the form.
        # The child is running the same process as the parent. So it's PID
        # is self()
        send(self(), {:created_demographics, demographics})
        # `send` needs to be handled by a handle_info callback in the parent.
        # the parent is Demographics.Show
        socket

      {:error, changeset} ->
        assign(socket, :changeset, changeset)
    end
  end

  defp params_with_user_id(params, socket) do
    Map.put(params, "user_id", socket.assigns.current_user.id)
  end

  defp assign_demographics(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographics, %Demographics{user_id: current_user.id})
  end

  defp assign_changeset(%{assigns: %{demographics: demographics}} = socket) do
    assign(socket, :changeset, Survey.change_demographics(demographics))
  end
end