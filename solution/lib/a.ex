defmodule IntroGS do
  use GenServer

  # Server

  @impl true
  def init(_args) do
    {:ok, []}
  end

  @impl true
  def handle_call(:get_todos, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:add_todo, item}, state) do
    {:noreply, [item | state]}
  end

  # Client (Convenience Functions)

  def start_todos() do
    GenServer.start_link(__MODULE__, [], name: :todos)
  end

  def get_todos() do
    GenServer.call(:todos, :get_todos)
  end

  def add_todo(item) do
    GenServer.cast(:todos, {:add_todo, item})
  end

end

### Übungsaufgabe

# Stelle einen Counter bereit:
# - Startet mit 0
# - Funktion, um Counter um 1 zu erhöhen
# - Funktion, um Counter-Zustand anzuzeigen

defmodule Counter do
  use GenServer

    # Server

    @impl true
    def init(_args) do
      {:ok, 0}
    end

    @impl true
    def handle_call(:get_counter, _from, state) do
      {:reply, state, state}
    end

    @impl true
    def handle_cast(:inc_counter, state) do
      {:noreply, state + 1}
    end

    # Client (Convenience Functions)

    def start_counter() do
      GenServer.start_link(__MODULE__, [], name: :counter)
    end

    def get_counter() do
      GenServer.call(:counter, :get_counter)
    end

    def inc_counter() do
      GenServer.cast(:counter, :inc_counter)
    end
end
