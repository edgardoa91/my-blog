defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  # Render main page.
  def index(conn, _params) do
    render(conn, "index.html")
  end

end
