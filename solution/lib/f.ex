defmodule CalculonFWorker do
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
  def init(n) do
    GenServer.cast(self(),{:calc_prime, n})
    {:ok, nil}
  end

  @impl true
  def handle_cast({:calc_prime, n}, state) do
    IO.puts("Processing #{n}")
    p? = prime?(n)
    is_it = if p? do
      "eine"
    else
      "keine"
    end
    IO.puts("#{n} ist #{is_it} Primzahl")
    Process.exit(self(), :normal)
    {:noreply, state}
  end

  def start_link(arg) do
    IO.puts("Starting Worker Calculon")
    GenServer.start_link(__MODULE__, arg)
  end
end
