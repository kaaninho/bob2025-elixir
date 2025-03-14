defmodule CalculonC do
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
    {:ok, nil}
  end

  @impl true
  def handle_call({:calc_prime, n}, _from,state) do
    p? = prime?(n)
    {:reply, p?, state}
  end

  def start_link(_args) do
    IO.puts("Starting Worker Calculon")
    GenServer.start_link(__MODULE__, nil, name: :calculon)
  end
end
