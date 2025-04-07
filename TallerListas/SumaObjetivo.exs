defmodule SumaObjetivo do
  def buscar_combinaciones(_, 0), do: [[]]


  def buscar_combinaciones([], _), do: []

  def buscar_combinaciones([x | xs], objetivo) do

    con_x = buscar_combinaciones(xs, objetivo - x)
    |> Enum.map(fn comb -> [x | comb] end)

    sin_x = buscar_combinaciones(xs, objetivo)

    con_x ++ sin_x
  end

  def main do
    lista = [2, 3, 5, 7]
    objetivo = 10

    combinaciones = buscar_combinaciones(lista, objetivo)
    IO.inspect(combinaciones)
  end
end

SumaObjetivo.main()
