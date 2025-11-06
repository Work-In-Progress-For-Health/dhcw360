defmodule Dryw.Accounts.Item do
  use Ash.Resource,
    otp_app: :drwy,
    domain: Dryw.Accounts,
    data_layer: AshPostgres.DataLayer
  use Dryw.Accounts.User.Fab

  def snake_case_singular(), do: "item"
  def snake_case_plural(), do: "items"
  def title_case_singular(), do: "Item"
  def title_case_plural(), do: "Items"

  postgres do
    table "items"
    repo Dryw.Repo
  end

  actions do
    defaults [:read, :destroy, create: [], update: []]
  end

  attributes do
    uuid_primary_key :id
    attribute :collaboration, :integer
    attribute :innovation, :integer
    attribute :inclusive, :integer
    attribute :excellence, :integer
    attribute :compassion, :integer
  end

  relationships do
    belongs_to :reviewer, Dryw.Accounts.User
    belongs_to :reviewee, Dryw.Accounts.User
  end

end
