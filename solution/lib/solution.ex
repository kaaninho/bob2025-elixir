defmodule Solution do
  use Application

  def start(_type, _args) do
    children = [
      %{id: :calc_sup,
        start: {CalculonCSupervisor, :start, []}},
      %{id: :calc_rec,
      start: {CalculonFReceiver, :start_link, []}}
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
