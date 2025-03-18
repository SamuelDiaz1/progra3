defmodule Tienda_tecnologica do
  def main() do
    inventario = %{"celular" => 5, "computador" => 4, "reloj" => 6}
    aux = actualizar_inventario(inventario, "celular", 3)
    IO.inspect(aux)
  end

  # Función que actualiza el inventario después de vender una cierta cantidad de un producto
  def actualizar_inventario(inventario, nombre_producto, cantidad_vendida) do
    # Usamos Enum.find para buscar el producto en el inventario.
    producto = Enum.find(inventario, fn {producto, _} -> producto == nombre_producto end)

    cond do
      # Si el producto no se encuentra en el inventario, retorna "Producto no encontrado"
      producto == nil ->
        "Producto no encontrado"

      # Si el stock del producto es menor que la cantidad vendida, retorna "Stock insuficiente"
      elem(producto, 1) < cantidad_vendida ->
        "Stock insuficiente"

      # Si ninguna de las condiciones anteriores es verdadera, se actualiza el inventario
      true ->
        # Usamos Enum.map para crear una nueva lista con el inventario actualizado
        inventario
        |> Enum.map(fn
          # Si el producto coincide con el nombre del producto vendido, restamos la cantidad vendida del stock
          {producto, stock} when producto == nombre_producto ->
            {producto, stock - cantidad_vendida}

          # Si no es el producto vendido, mantenemos el inventario igual
          item -> item
        end)
    end
  end
end

Tienda_tecnologica.main()
