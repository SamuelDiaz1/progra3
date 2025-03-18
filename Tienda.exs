defmodule Tienda do
  def main() do
    productos = [
      {"Producto A", 100},
      {"Producto B", 200},
      {"Producto C", 300}
    ]

    Tienda.calcular_descuentos(productos, 10)
  end

  def calcular_descuentos(productos, porcentaje_descuento) do
    # Verificar si la lista de productos está vacía
    if productos == [] do
      {[], 0}
    else
      # Usar Enum.map para calcular los precios con descuento
      lista_descuentos =
        Enum.map(productos, fn {nombre, precio} ->
          # Calcular el descuento para cada producto
          descuento = precio * (porcentaje_descuento / 100)
          precio_con_descuento = precio - descuento
          {nombre, precio_con_descuento}
        end)

      # Calcular el total del descuento aplicado usando Enum.sum
      total_descuento =
        Enum.sum(
          Enum.map(productos, fn {_, precio} ->
            precio * (porcentaje_descuento / 100)
          end)
        )

      # Retornar la lista con los descuentos y el total de descuento
      IO.inspect({lista_descuentos, total_descuento})
    end
  end
end

Tienda.main()
