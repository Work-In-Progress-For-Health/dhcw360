defmodule Dryw.Fab do

  def fab_email() do
    "#{Ecto.UUID.generate()}@example.com"
  end

end
