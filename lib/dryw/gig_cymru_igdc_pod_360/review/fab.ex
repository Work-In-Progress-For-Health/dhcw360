defmodule Dryw.GigCymruIgdcPod360.Review.Fab do
  defmacro __using__(_opts) do
    quote do

      def fab!(map \\ %{}) do
        __MODULE__ |> Ash.Changeset.for_create(:create, __MODULE__.fab_map(map)) |> Ash.create!()
      end

      def fab_map(map \\ %{}) do
        Map.merge(
          %{
            collaboration: 1,
            innovation: 2,
            inclusive: 3,
            excellence: 4,
            compassion: 5,
          },
          map
        )
      end

    end
  end
end
