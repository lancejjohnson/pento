defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign_recipient()
      |> assign_changeset()
    }
  end

  def assign_recipient(socket) do
    assign(socket, :recipient, %Recipient{})
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    assign(socket, :form, to_form(Promo.change_recipient(recipient)))
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      # phx won't display errors without an action on the changeset
      |> Map.put(:action, :validate)

    # NB: This is different than the text of the book because of book errata
    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  # TODO: I just made this up. it should include some kind of notification to
  # the user confirming what happened. Likely should also redirect the user to
  # a different page.
  def handle_event(
        "save",
        %{"recipient" => recipient_params},
        %{
          assigns: %{recipient: recipient}
        } = socket
      ) do
    {:ok, _} = Promo.send_promo(recipient, %{})

    {
      :noreply,
      socket
      |> assign_recipient()
      |> assign_changeset()
    }
  end
end
