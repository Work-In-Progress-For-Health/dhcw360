defmodule Dryw.Accounts.User.Fab do
  defmacro __using__(_opts) do
    quote do

      def fab!(map \\ %{}) do
        __MODULE__ |> Ash.Changeset.for_create(:create, __MODULE__.fab_map(map)) |> Ash.create!()
      end

      def fab_map(map \\ %{}) do
        Map.merge(
          %{
            email: "#{Ecto.UUID.generate()}@example.com",
          },
          map
        )
      end

    end
  end
end
