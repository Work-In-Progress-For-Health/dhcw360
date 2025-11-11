defmodule DrywWeb.Components.Radio do
  use Phoenix.Component

  @doc """
  Render a radio button input for a given form field.

  ## Examples:

      <:radio value="1">Alfa</:radio>
      <:radio value="2">Bravo</:radio>
      <:radio value="3">Charlie</:radio>

  """

  attr :field, Phoenix.HTML.FormField, required: true
  attr :index, :integer, required: true
  attr :value, :string, required: true

  slot :inner_block, required: true

  def radio(assigns) do
    ~H"""
    <label>
      <input
        type="radio"
        name={@field.name}
        id={"#{@field.id}-#{@index}"}
        value={@value}
        checked={to_string(@field.value) == to_string(@value)}
      />
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  @doc """
  Render a radio group input for a given form field.

  Source: https://github.com/phoenixframework/phoenix/pull/5506

  ## Examples

      <.radio_group field={@my_form[:my_field]}>
        <:radio value="1">Alfa</:radio>
        <:radio value="2">Bravo</:radio>
        <:radio value="3">Charlie</:radio>
      </.radio_group>

  """
  attr :field, Phoenix.HTML.FormField, required: true

  slot :radio, required: true do
    attr :value, :string, required: true
  end

  slot :inner_block

  def radio_group(assigns) do
    ~H"""
    <div>
      <%= render_slot(@inner_block) %>
      <div :for={{radio, idx} <- Enum.with_index(@radio)}>
        <label>
          <input
            type="radio"
            name={@field.name}
            id={"#{@field.id}-#{idx}"}
            value={radio.value}
            checked={to_string(@field.value) == to_string(radio.value)}
          />
          <%= render_slot(radio) %>
        </label>
      </div>
    </div>
    """
  end
end
