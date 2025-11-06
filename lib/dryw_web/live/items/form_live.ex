defmodule DrywWeb.Items.FormLive do
  use DrywWeb, :live_view
  alias Dryw.Accounts.Item, as: X

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
        li {
        }
        </style>

        <.section_with_radio
          form={form}
          id={:collaboration}
          h2="Collaboration"
          p="Examples: Teamwork • Supporting and challenging • Listening and valuing each other • Reflecting • Continuous learning"
        />

        <.section_with_radio
          form={form}
          id={:innovation}
          h2="Innovation"
          p="Examples: Creative thinking • Courageous • Transformational • Embracing change • Ambitious"
        />

        <.section_with_radio
          form={form}
          id={:inclusive}
          h2="Inclusive"
          p="Examples: Diversity • Equality • Respect • Fairness • Equity • Celebrate success and achievements"
        />

        <.section_with_radio
          form={form}
          id={:excellence}
          h2="Excellence"
          p="Examples: Empowerment • Quality • Continuous improvement • Drive for results • Pride in what we do • Accountability"
        />

        <.section_with_radio
          form={form}
          id={:compassion}
          h2="Compassion"
          p="Examples: Dignity • Kindness • Empathy • Personal responsibility • Trust"
        />

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
