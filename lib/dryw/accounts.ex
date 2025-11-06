defmodule Dryw.Accounts do
  use Ash.Domain,
    otp_app: :drwy

  resources do
    resource Dryw.Accounts.Token
    resource Dryw.Accounts.User
    resource Dryw.Accounts.Item
  end
end
