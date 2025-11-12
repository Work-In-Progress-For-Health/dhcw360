defmodule Dryw.GigCymruIgdcPod360.Review do
  use Ash.Resource,
    otp_app: :dryw,
    domain: Dryw.Accounts,
    data_layer: AshPostgres.DataLayer
  use Dryw.Accounts.User.Fab

  def snake_case_singular(), do: "review"
  def snake_case_plural(), do: "reviews"
  def title_case_singular(), do: "Review"
  def title_case_plural(), do: "Reviews"

  postgres do
    table "gig_cymru_igdc_pod_360_reviews"
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
