defmodule CurrentlyWeb.PageController do
  use CurrentlyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
