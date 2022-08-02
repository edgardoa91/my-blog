defmodule BlogWeb.PageLive do
  use BlogWeb, :live_view

  def render(assigns) do
    Phoenix.View.render(BlogWeb.PageView, "index.html", assigns)
  end
end


