# GIG Cymru IGDC Dryw

GIG Cymru IGDC Dryw / NHS Wales DHCW Wren:

- This is a web app for custom staff surveys using agile discovery for Digital Health and Care Wales (DHCW) Values-Based 360 Feedback.

- This is research work in progress, not for official use nor production use.

- Prototype launch goal is event on November 10 2025 featuring AI and HR.

## Run

Run:

```sh
git clone https://github.com/work-in-progress-for-health/gig-cymru-igdc-dryw
cd gig-cymru-igdc-dryw
mix ash.setup
mix cinder.install
mix phx.server
```

## Development

To develop this app from scratch, here are steps.

### Create

```sh
mix igniter.new dryw --module Dryw --with phx.new --install ash,ash_phoenix,ash_postgres,ash_backpex,cinder,mdex,recase
cd dryw
```

### Authentication

Create a user with authentication magic link:

```sh
mix igniter.install ash_authentication_phoenix --auth-strategy magic_link
mix ash.migrate
```

### Generate

Copy scripts to generate resources from preexisting sources.

Run:

```sh
priv/generate/user
priv/generate/item
```

## Generate resource diagrams

Run:

```sh
mix ash.generate_resource_diagrams
```

## Update

Run:

```sh
mix deps.update --all
```

Clean:

```sh
mix clean
mix deps.update --all
mix deps.clean --all
mix deps.get
mix compile
```

## Update deps

Download:

```sh
mkdir -p lib/mix/tasks/
curl "https://raw.githubusercontent.com/joelparkerhenderson/elixir-mix-task-to-update-deps-versions/refs/heads/main/update_deps_versions.ex" \
   -o lib/mix/tasks/update_deps_versions.ex
```

Run:

```sh
mix update_deps_versions
```

## Redo data

Run:

```sh
for env in dev test; do
   export MIX_ENV=$env
   mix
   mix ecto.reset
   mix ash.codegen tmp
   rm priv/repo/migrations/*_tmp.exs
   rm priv/repo/migrations/*_tmp_extensions_1.exs
   mix ash.migrate
done
export MIX_ENV=test && mix && mix test
export MIX_ENV=dev && mix && mix phx.server
```

## Redo dependencies

Run:

```sh
mix deps.clean ash_authentication_phoenix --build
mix deps.get
mix compile --force
```
