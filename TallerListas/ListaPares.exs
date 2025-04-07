defmodule ListaPares do
  def main() do
    lista = [1, 2, 3, 4, 5, 6]
    IO.puts("Cantidad de pares: #{contar_pares(lista)}")
  end

  def contar_pares([]), do: 0 #Caso base

  def contar_pares([cabeza | cola]) do
    if rem(cabeza, 2) == 0 do
      1 + contar_pares(cola)
    else
      contar_pares(cola)
    end
  end

end
ListaPares.main()
