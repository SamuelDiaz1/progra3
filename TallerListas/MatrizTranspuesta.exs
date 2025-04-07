defmodule MatrizTranspuesta do

  def transponer([]), do: []

  def transponer([[] | _]), do: []  # Cuando todas las filas están vacías

  def transponer(matriz) do
    primera_columna = Enum.map(matriz, fn fila -> hd(fila) end)
    resto_matriz = Enum.map(matriz, fn fila -> tl(fila) end)

    [primera_columna | transponer(resto_matriz)]
  end

  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6]
    ]

    IO.inspect(transponer(matriz))
  end

end
MatrizTranspuesta.main()
