defmodule DrywWeb.PageController do
  use DrywWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
