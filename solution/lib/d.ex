defmodule CalculonD do
  use GenServer

  @spec prime?(integer()) :: boolean()
  defp prime?(1), do: false
  defp prime?(2), do: true
  defp prime?(n) do
    Process.sleep(3000)
    if :rand.uniform(5) < 3 do
      raise "EXCEPTION: ERROR IN PRIME"
    end
    Enum.reduce(Range.new(2, n - 1), true, fn x, acc -> rem(n, x) != 0 and acc end)
  end

  @impl true
  def init(_args) do
    GenServer.cast(self(), :process)
    {:ok, []}
  end

  @impl true
  def handle_cast({:calc_prime, n},state) do
    {:noreply, state ++ [n]}
  end

  def handle_cast(:process, []) do
    IO.puts("Nothing to do")
    Process.sleep(2000)
    GenServer.cast(self(), :process)
    {:noreply,[]}
  end

  def handle_cast(:process, [x | rest]) do
    IO.puts("Processing #{x}..., elems left: #{rest}")
    p? = prime?(x)
    is_it = if p? do
      "eine"
    else
      "keine"
    end
    IO.puts("#{x} ist #{is_it} Primzahl")
    GenServer.cast(self(), :process)
    {:noreply, rest}
  end

  def start_link(_args) do
    IO.puts("Starting Worker Calculon")
    GenServer.start_link(__MODULE__, nil, name: :calculond)
  end
end
