defmodule DrywWeb.Users.FormLive do
  use DrywWeb, :live_view
  alias Dryw.Accounts.User, as: X

  require Logger

  @doc """
  Mount the LiveView:
  - Update a resource via an item id.
  - Create a new resource.
  """

  def mount(%{"id" => id}, _session, socket) do
    form = AshPhoenix.Form.for_action(X, :update, domain: Dryw.Works)
    x = Ash.get!(X, id)

    {:ok,
     assign(socket,
       page_title: "Edit #{x.title_case_singular()}",
       form: to_form(form),
       x: x
     )}
  end

  def mount(_params, _session, socket) do
    form = AshPhoenix.Form.for_create(X, :create)

    {:ok,
     assign(socket,
       page_title: "New #{X.title_case_singular()}",
       form: to_form(form)
     )}
  end

  @doc """
  Render.
  """
  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        {@page_title}
      </.header>

      <.form
        :let={form}
        id="x_form"
        for={@form}
        as={:form}
        phx-change="validate"
        phx-submit="save"
      >

        <style>
        label {
          display: block;
          color: red;
        }
        </style>

        <!-- TODO: required -->
        <.input
          type="textarea"
          field={form[:email]}
          label="Your email address:"
          placeholder="example@example.com"
          autofocus
          cols="80"
          rows="1"
        />

        <h2>What email addresses do you want to invite to review you?</h2>

        <!-- TODO: required -->
        <.input
          type="textarea"
          field={form[:primary_manager_email_address]}
          label="Your primary manager:"
          placeholder="example@example.com"
          cols="80"
          rows="3"
        />

        <.input
          type="textarea"
          field={form[:secondary_managers_email_addresses]}
          label="Your secondary managers, if applicable:"
          placeholder="example@example.com, example@example.com, example@example.com"
          cols="80"
          rows="3"
        />

        <.input
          type="textarea"
          field={form[:direct_reports_email_addresses]}
          label="Your direct reports, if applicable:"
          placeholder="example@example.com, example@example.com, example@example.com"
          cols="80"
          rows="3"
        />

        <.input
          type="textarea"
          field={form[:peers_email_addresses]}
          label="Your peers, if applicable:"
          placeholder="example@example.com, example@example.com, example@example.com"
          cols="80"
          rows="3"
        />

        <.input
          type="textarea"
          field={form[:others_email_addresses]}
          label="Your other connections, such as coworkers, collaborators, etc.:"
          placeholder="example@example.com, example@example.com, example@example.com"
          cols="80"
          rows="3"
        />

        <!-- TODO: validate that the person has invited at least 5 people -->
        <.button type="primary">Save</.button>
      </.form>
    </Layouts.app>
    """
  end

  @doc """
  Handle event:
    - update now to try to work around DaisyUI collapse bug
    - validate form data
    - save form data to the database
  """

  def handle_event("updater", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", %{"form" => form_data}, socket) do
    # form_data = convert_tags_param(form_data)
    {:noreply,
     update(
       socket,
       :form,
       fn form -> AshPhoenix.Form.validate(form, form_data) end
     )}
  end

  def handle_event("save", %{"form" => form_data}, socket) do
    # form_data = convert_tags_param(form_data)
    case AshPhoenix.Form.submit(socket.assigns.form, params: form_data) do
      {:ok, _x} ->
        {:noreply,
         socket
         |> put_flash(:info, "Saved.")
         |> push_navigate(to: "/")}

      {:error, form} ->
        {:noreply,
         socket
         |> put_flash(:error, "Save failed.")
         |> assign(:form, form)}
    end
  end
end
