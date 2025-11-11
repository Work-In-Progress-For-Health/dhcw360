defmodule DrywWeb.GigCymruIgdcPod360.Reviews.Test do
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

    {:ok, conn: conn}
  end

  test "new", %{conn: conn} do
    conn = get(conn, ~p"/gig-cymru/igdc/pod/360/reviews/new")
    response = html_response(conn, 200)
    assert response =~ "Collaboration"
    assert response =~ "Innovation"
    assert response =~ "Inclusive"
    assert response =~ "Excellence"
    assert response =~ "Compassion"
  end

  test "create", %{conn: conn} do
    {:ok, lv, _html} = live(conn, ~p"/gig-cymru/igdc/pod/360/reviews/new")
    result =
      lv
      |> form("#x_form", %{
        "form[collaboration]" => 1,
        "form[innovation]" => 2,
        "form[inclusive]" => 3,
        "form[excellence]" => 4,
        "form[compassion]" => 5,
      })
      |> render_submit()
    case result do
      {:error, {:live_redirect, %{to: path}}} ->
        assert path == "/traits"
      html when is_binary(html) ->
        assert html =~ "Diolch / Thanks"
      other ->
        flunk("Unexpected result: #{inspect(other)}")
    end
  end
end
