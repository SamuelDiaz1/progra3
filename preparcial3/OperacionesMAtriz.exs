defmodule OperacionesMatriz do
  @doc """
  Suma los elementos por debajo de la diagonal principal de forma recursiva.
  """
  def sumar_bajo_diagonal(matriz) do
    sumar_bajo_diagonal_auxiliar(matriz, 0, 0, 0)
  end

  defp sumar_bajo_diagonal_auxiliar(matriz, i, _j, suma) when i >= length(matriz), do: suma

  defp sumar_bajo_diagonal_auxiliar(matriz, i, j, suma) when j >= i do
    # Pasamos a la siguiente fila
    sumar_bajo_diagonal_auxiliar(matriz, i + 1, 0, suma)
  end
  defp sumar_bajo_diagonal_auxiliar(matriz, i, j, suma) do
    # Sumamos el elemento actual y continuamos con la siguiente columna
    valor_actual = Enum.at(matriz, i) |> Enum.at(j)
    sumar_bajo_diagonal_auxiliar(matriz, i, j + 1, suma + valor_actual)
  end

  @doc """
  Calcula el promedio de los elementos por encima de la diagonal principal.
  """
  def promedio_sobre_diagonal(matriz) do
    {suma, contador} = sumar_y_contar_sobre_diagonal(matriz)
    if contador > 0, do: suma / contador, else: 0
  end

defp sumar_y_contar_sobre_diagonal(matriz) do
  n = length(matriz)

  Enum.reduce(0..(n-2), {0, 0}, fn i, {suma, contador} ->
    Enum.reduce((i+1)..(n-1), {suma, contador}, fn j, {suma_acum, contador_acum} ->
      valor = Enum.at(matriz, i) |> Enum.at(j)
      {suma_acum + valor, contador_acum + 1}
    end)
  end)
end
end

defmodule Principal do
  def main do
    # Definimos una matriz de ejemplo
    matriz = [
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 10, 11, 12],
      [13, 14, 15, 16]
    ]

    # Lanzamos los procesos t1 y t2
    t1 = Task.async(fn -> OperacionesMatriz.sumar_bajo_diagonal(matriz) end)
    t2 = Task.async(fn -> OperacionesMatriz.promedio_sobre_diagonal(matriz) end)

    # Esperamos a que terminen y obtenemos sus resultados
    a = Task.await(t1)
    b = Task.await(t2)

    # S3: c = a * b
    c = a * b

    # S4: Imprimimos c
    IO.puts("Suma por debajo de la diagonal (a): #{a}")
    IO.puts("Promedio por encima de la diagonal (b): #{b}")
    IO.puts("Resultado (c = a * b): #{c}")
  end
end

# Ejecutamos el programa
Principal.main()
