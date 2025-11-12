defmodule DrywWeb.Users.Test do
  import Phoenix.LiveViewTest
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

  test "edit", %{conn: conn, user: user} do
    conn = get(conn, ~p"/users/#{user.id}/edit")
    response = html_response(conn, 200)
    assert response =~ "Your primary manager"
    assert response =~ "Your secondary managers"
    assert response =~ "Your direct reports"
    assert response =~ "Any peers"
    assert response =~ "Any others"
  end

  test "update", %{conn: conn, user: user} do
    {:ok, lv, _html} = live(conn, ~p"/users/#{user.id}/edit")
    result =
      lv
      |> form("#x_form", %{
        "form[primary_manager_email_address]" => "primarymanager@example.com",
        "form[secondary_managers_email_addresses]" => "secondarymanager0@example.com, secondarymanager1@example.com",
        "form[direct_reports_email_addresses]" => "directs0@example.com, directs1@example.com",
        "form[peers_email_addresses]" => "peers0@example.com, peers1@example.com",
        "form[others_email_addresses]" => "others0@example.com, others1@example.com",
      })
      |> render_submit()
    case result do
      {:error, {:live_redirect, %{to: path}}} ->
        assert path == "/traits"
      html when is_binary(html) ->
        assert html =~ "Your primary manager" #TODO
      other ->
        flunk("Unexpected result: #{inspect(other)}")
    end
  end
end
