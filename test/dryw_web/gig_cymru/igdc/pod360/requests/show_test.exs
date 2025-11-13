defmodule DrywWeb.GigCymru.Igdc.Pod360.ShowTest do
  use DrywWeb.ConnCase
  use DrywWeb.AuthCase

  setup %{conn: conn} do
    user = my_user!()
    user = my_sign_in!(user)
    conn =
      conn
      |> Phoenix.ConnTest.init_test_session(%{})
      |> AshAuthentication.Plug.Helpers.store_in_session(user)

    {:ok, conn: conn, user: user}
  end

  test "show", %{conn: conn, user: user} do
    conn = get(conn, ~p"/gig-cymru/igdc/pod360/requests/#{user.email}")
    response = html_response(conn, 200)
    x = user

    assert response =~ "From: #{x.email}"
    assert response =~ "To: #{Dryw.Accounts.User.emails(x)}"

  end

end
