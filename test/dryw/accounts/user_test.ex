defmodule UserTest do
  alias Dryw.Accounts.User, as: X
  use ExUnit.Case
  # import ExUnitProperties
  # import Generator

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Navatrack.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Dryw.Repo, {:shared, self()})
    :ok
  end

  test "fab!" do
    X.fab!()
  end

end
