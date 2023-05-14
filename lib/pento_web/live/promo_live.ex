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

  # def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
  #   assign(socket, :changeset, IO.inspect(to_form(Promo.change_recipient(recipient)), label: "THE FORM" ))
  # end
end
