defmodule CalculonCSupervisor do
  use Supervisor

  @impl true
  def init(_args) do
    children = [
      {CalculonC, 0}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def start() do
    Supervisor.start_link(__MODULE__, 3, name: CalculonSupervisor)
  end
end
