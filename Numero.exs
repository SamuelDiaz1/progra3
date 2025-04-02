defmodule MayorPila do
  def obtener_mayor([unico]), do: unico

  def obtener_mayor(lista) do
    mitad = div(length(lista), 2)
    {izquierda, derecha} = Enum.split(lista, mitad)

    max_izq = obtener_mayor(izquierda)
    max_der = obtener_mayor(derecha)

    max(max_izq, max_der)
  end
end
