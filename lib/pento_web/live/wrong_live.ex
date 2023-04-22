defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view
  alias Pento.Accounts

  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess:",
       number: pick_number(),
       session_id: session["live_socket_id"]
     )}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2><%= @message %></h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
    </h2>
    <h2>
      Shhhh! The number is: <%= @number %>
    </h2>
    <.link patch={~p"/guess/"}>Reset</.link>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    IO.inspect(socket, label: "socket")

    {
      :noreply,
      assign(
        socket,
        message: build_message(guess, socket.assigns),
        score: updated_score(guess, socket.assigns)
      )
    }
  end

  def handle_params(_params, _uri, socket) do
    {
      :noreply,
      assign(
        socket,
        message: "Make a guess",
        score: 0,
        number: pick_number()
      )
    }
  end

  defp pick_number(candidates \\ 1..10) do
    candidates |> Enum.random() |> Integer.to_string()
  end

  defp build_message(number, %{number: number}) do
    "Congratulations! You guess correctly!"
  end

  defp build_message(guess, %{number: _number}) do
    "Your guess #{guess} is incorrect. Guess again."
  end

  defp updated_score(number, %{number: number, score: score}) do
    score
  end

  defp updated_score(_guess, %{number: _number, score: score}) do
    score - 1
  end
end
