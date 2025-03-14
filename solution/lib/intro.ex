defmodule Intro do
    @doc """
  Erhöht eine Zahl um 1

  ## Beispiel

      iex> Todo.addiere_1(4)
      5

  """
  @spec addiere_1(integer()) :: integer()
  def addiere_1(zahl) do
    zahl + 1
  end

  @doc """
  Testet, ob geg. Tag zum Wochenende gehört.

  Gibt Boolean zurück
  """
  @spec wochenende?(String.t()) :: boolean()
  # def wochenende?(tag) do
  #   case tag do
  #     "Samstag" -> true
  #     "Sonntag" -> true
  #     _other    -> false
  #   end
  # end

  def wochenende?("Samstag"), do: true
  def wochenende?("Sonntag"), do: true
  def wochenende?(_), do: false

  @doc """

  Teilt eine Zahl durch eine andere

  """
  @spec teile(number(), number()) :: {:ok, number()} | {:error, :division_durch_null}
  def teile(zähler, nenner) do
    if nenner == 0 do
      {:error, :division_durch_null}
    else
      {:ok, zähler / nenner}
    end
  end

  def print_teile(z, n) do
    case teile(z,n) do
      {:ok, result} -> IO.puts("#{z} durch #{n} ergibt #{result}")
      {:error, _} -> IO.puts("Man darf nicht durch Null teilen")
    end

  end
end
