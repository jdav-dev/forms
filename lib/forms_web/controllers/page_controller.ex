defmodule FormsWeb.PageController do
  use FormsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def no_nested(conn, _params) do
    render(conn, "no_nested.html")
  end
end
