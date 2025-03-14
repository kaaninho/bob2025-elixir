defmodule CalculonB do

  @spec prime?(integer()) :: boolean()
  def prime?(1), do: false
  def prime?(2), do: true
  def prime?(n) do
    Process.sleep(3000)
    if :rand.uniform(5) < 3 do
      raise "EXCEPTION: ERROR IN PRIME"
    end
    Enum.reduce(Range.new(2, n - 1), true, fn x, acc -> rem(n, x) != 0 and acc end)
  end
end
