defmodule Dryw.Accounts.User.Fab do
  defmacro __using__(_opts) do
    quote do
      import Dryw.Fab

      def fab!(map \\ %{}) do
        __MODULE__ |> Ash.Changeset.for_create(:create, __MODULE__.fab_map(map)) |> Ash.create!()
      end

      def fab_map(map \\ %{}) do
        Map.merge(
          %{
            email: fab_email(),
            primary_manager_email_address: fab_email(),
            secondary_managers_email_addresses: "#{fab_email()}, #{fab_email()}",
            direct_reports_email_addresses:  "#{fab_email()}, #{fab_email()}",
            peers_email_addresses: "#{fab_email()}, #{fab_email()}",
            others_email_addresses: "#{fab_email()}, #{fab_email()}",
          },
          map
        )
      end

    end
  end
end
