defmodule Sequence2 do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, initial_number) do
    {:ok, _pid} = Sequence.Supervisor.start_link(Application.get_env(:sequence2, :initial_number))
  end
end
