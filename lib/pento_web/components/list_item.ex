defmodule PentoWeb.ListItem do
  use Phoenix.Component

  slot :inner_block, required: true

  def item(assigns) do
    ~H"""
    <li>
      render_slot(@inner_block)
    </li>
    """
  end
end
