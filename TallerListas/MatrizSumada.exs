defmodule MatrizSumada do
  def sumar_matriz([]), do: 0  # Caso base: matriz vacía

  def sumar_matriz([fila | resto]) do
    sumar_fila(fila) + sumar_matriz(resto)
  end

  def sumar_fila([]), do: 0

  def sumar_fila([c | r]) do
    c + sumar_fila(r)
  end

  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
    IO.puts("Suma total: #{sumar_matriz(matriz)}")
  end
end
MatrizSumada.main()
