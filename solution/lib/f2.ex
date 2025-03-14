defmodule CalculonFReceiver do
  use GenServer

  def calc_prime(n) do
    GenServer.cast(__MODULE__, {:calc_prime, n})
  end

  @impl true
  def handle_cast({:calc_prime, n}, state) do
    {:ok, pid} = GenServer.start(CalculonFWorker,n)
    Process.monitor(pid)
    {:noreply, Map.put(state, pid, n)}
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, pid, :normal}, state) do
    IO.inspect("NORMAL shutdown of Worker")
    IO.inspect("state: #{inspect(state)}")
    IO.inspect(pid)
    IO.puts("new state #{inspect(Map.delete(state, pid))}")
    {:noreply, Map.delete(state, pid)}
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, pid, _reason}, state) do
    IO.inspect("ERROR shutdown of Worker")
    IO.puts("pid #{inspect(pid)}")
    GenServer.start(CalculonFWorker, Map.get(state,pid))
    {:noreply, Map.delete(state, pid)}
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  def start_link() do
    GenServer.start_link(__MODULE__,nil, name: __MODULE__)
  end


end
