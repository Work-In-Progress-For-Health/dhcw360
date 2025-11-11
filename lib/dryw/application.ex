defmodule Dryw.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DrywWeb.Telemetry,
      Dryw.Repo,
      {DNSCluster, query: Application.get_env(:dryw, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Dryw.PubSub},
      # Start a worker by calling: Dryw.Worker.start_link(arg)
      # {Dryw.Worker, arg},
      # Start to serve requests, typically the last entry
      DrywWeb.Endpoint,
      {AshAuthentication.Supervisor, [otp_app: :dryw]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dryw.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DrywWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
