defmodule ListaInvertida do
  def invertir_lista(lista), do: invertir_lista(lista, [])

  def invertir_lista([], acumulador), do: acc #Caso base

  def invertir_lista([cabeza | cola], acc) do
    invertir_lista(cola, [cabeza | acc])
  end

  def main do
    lista = [1, 2, 3, 4, 5]
    IO.inspect(invertir_lista(lista))
  end
end
ListaInvertida.main()
