defmodule Matriz do
  def recorrer_diagonal(matriz) do
    recorrer_diagonal(matriz, 0, [])
  end
  defp recorrer_diagonal(matriz, i, acumulador) when i < length(matriz) do
  fila = Enum.at(matriz, i)
  valor = Enum.at(fila, i)
  recorrer_diagonal(matriz, i + 1, acumulador ++ [valor])
  end
  defp recorrer_diagonal(_,_,acumulador), do: acumulador

  end
  matriz = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
  ]
  IO.inspect Matriz.recorrer_diagonal (matriz)
