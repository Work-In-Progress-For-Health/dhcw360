defmodule Dryw.Accounts do
  use Ash.Domain,
    otp_app: :dryw

  resources do
    resource Dryw.Accounts.Token
    resource Dryw.Accounts.User
    resource Dryw.GigCymru.Igdc.Pod360.Review
  end
end
