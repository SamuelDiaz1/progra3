defmodule NumeroMax do
  def obtener_mayor([unico]), do: unico

  def obtener_mayor(lista) do
    mitad = div(length(lista), 2)
    {izquierda, derecha} = Enum.split(lista, mitad)

    max_izq = obtener_mayor(izquierda)
    max_der = obtener_mayor(derecha)

    max(max_izq, max_der)
  end
  def main() do
    lista= [7,6,8,4,5]
    IO.puts(obtener_mayor(lista))
  end
end
NumeroMax.main()
