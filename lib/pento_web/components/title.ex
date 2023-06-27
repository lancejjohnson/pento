defmodule PentoWeb.Title do
  use Phoenix.Component

  attr :message, :string, required: false
  slot :inner_block, required: true

  def title(assigns) do
    ~H"""
    <h1><%= render_slot(@inner_block) %></h1>
    <%= if message = assigns[:message] do %>
      <span><%= message %></span>
    <% end %>
    """
  end
end
