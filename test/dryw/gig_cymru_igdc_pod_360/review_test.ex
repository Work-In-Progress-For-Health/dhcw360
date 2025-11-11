defmodule ItemTest do
  alias Dryw.GigCymruIgdcPod360.Review, as: X
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
