defmodule Dryw.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        Dryw.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:dryw, :token_signing_secret)
  end
end
