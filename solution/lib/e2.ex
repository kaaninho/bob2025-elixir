defmodule CalculonEReceiver do
  def calc_prime(n) do
    {:ok, _} = GenServer.start(CalculonEWorker,n)
  end
end
