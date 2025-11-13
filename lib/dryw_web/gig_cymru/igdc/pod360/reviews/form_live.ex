defmodule DrywWeb.GigCymru.Igdc.Pod360.Reviews.FormLive do
  use DrywWeb, :live_view
  alias DrywWeb.Layouts
  import DrywWeb.Components.SectionHeadlineParagraph
  import DrywWeb.Components.Radio
  alias Dryw.GigCymru.Igdc.Pod360.Review, as: X

  require Logger

  @doc """
  Mount the LiveView:
  - Update a resource via an item id.
  - Create a new resource.
  """

  def mount(%{"id" => id}, _session, socket) do
    actor = socket.assigns.current_user
    x = Ash.get!(X, id, domain: Dryw.Accounts, actor: actor)
    form = AshPhoenix.Form.for_update(x, :update, domain: Dryw.Accounts, actor: actor)

    {:ok,
     assign(socket,
       page_title: "Edit #{X.title_case_singular()}",
       form: to_form(form),
       x: x,
       reviewee: x.reviewee
     )}
  end

  def mount(%{"reviewee" => reviewee_email}, _session, socket) do
    actor = socket.assigns.current_user
    reviewee =  Ash.get!(Dryw.Accounts.User, [email: reviewee_email], domain: Dryw.Accounts, actor: actor)
    form = AshPhoenix.Form.for_action(X, :create, domain: Dryw.Accounts, actor: actor)

    {:ok,
     assign(socket,
       page_title: "New #{X.title_case_singular()}",
       form: to_form(form),
       reviewee: reviewee
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
        p {
        font-size: 1em;
        }
        li {
        }
        </style>

        <ul class="pb-6">
          <li>From: {@current_user.email}</li>
          <li>To: {@reviewee.email}</li>
        </ul>

        <.section_headline_paragraph
          id={:section_collaboration}
          headline="Collaboration"
          paragraph="Examples: Teamwork • Supporting and challenging • Listening and valuing each other • Reflecting • Continuous learning"
        >
          <.radio_group field={@form[:collaboration]}>
            <:radio value="1">Rarely = 10% of the time or less</:radio>
            <:radio value="2">Seldom = 30% of the time</:radio>
            <:radio value="3">Occasionally = 50% of the time</:radio>
            <:radio value="4">Often = 70% of the time</:radio>
            <:radio value="5">Frequently = 90% of the time or more</:radio>
            <:radio value="0">No opportunity to observe</:radio>
          </.radio_group>
        </.section_headline_paragraph>

        <.section_headline_paragraph
          id={:section_innovation}
          headline="Innovation"
          paragraph="Examples: Creative thinking • Courageous • Transformational • Embracing change • Ambitious"
        >
          <.radio_group field={@form[:innovation]}>
            <:radio value="1">Rarely = 10% of the time or less</:radio>
            <:radio value="2">Seldom = 30% of the time</:radio>
            <:radio value="3">Occasionally = 50% of the time</:radio>
            <:radio value="4">Often = 70% of the time</:radio>
            <:radio value="5">Frequently = 90% of the time or more</:radio>
            <:radio value="0">No opportunity to observe</:radio>
          </.radio_group>
        </.section_headline_paragraph>

        <.section_headline_paragraph
          id={:section_inclusive}
          headline="Inclusive"
          paragraph="Examples: Diversity • Equality • Respect • Fairness • Equity • Celebrate success and achievements"
        >
          <.radio_group field={@form[:inclusive]}>
            <:radio value="1">Rarely = 10% of the time or less</:radio>
            <:radio value="2">Seldom = 30% of the time</:radio>
            <:radio value="3">Occasionally = 50% of the time</:radio>
            <:radio value="4">Often = 70% of the time</:radio>
            <:radio value="5">Frequently = 90% of the time or more</:radio>
            <:radio value="0">No opportunity to observe</:radio>
          </.radio_group>
        </.section_headline_paragraph>

        <.section_headline_paragraph
          id={:section_excellence}
          headline="Excellence"
          paragraph="Examples: Empowerment • Quality • Continuous improvement • Drive for results • Pride in what we do • Accountability"
        >
          <.radio_group field={@form[:excellence]}>
            <:radio value="1">Rarely = 10% of the time or less</:radio>
            <:radio value="2">Seldom = 30% of the time</:radio>
            <:radio value="3">Occasionally = 50% of the time</:radio>
            <:radio value="4">Often = 70% of the time</:radio>
            <:radio value="5">Frequently = 90% of the time or more</:radio>
            <:radio value="0">No opportunity to observe</:radio>
          </.radio_group>
        </.section_headline_paragraph>

        <.section_headline_paragraph
          id={:section_compassion}
          headline="Compassion"
          paragraph="Examples: Dignity • Kindness • Empathy • Personal responsibility • Trust"
        >
          <.radio_group field={@form[:compassion]}>
            <:radio value="1">Rarely = 10% of the time or less</:radio>
            <:radio value="2">Seldom = 30% of the time</:radio>
            <:radio value="3">Occasionally = 50% of the time</:radio>
            <:radio value="4">Often = 70% of the time</:radio>
            <:radio value="5">Frequently = 90% of the time or more</:radio>
            <:radio value="0">No opportunity to observe</:radio>
          </.radio_group>
        </.section_headline_paragraph>

        <!-- TODO: validate that the person has submitted enough information -->
        <div class="mt-2 mb-8">
          <.button type="primary">Save</.button>
        </div>

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
