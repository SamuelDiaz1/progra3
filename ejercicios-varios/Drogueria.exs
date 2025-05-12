defmodule Drogueria do
  def main() do
    ventas=%{}
    analisis= analizar_ventas(ventas)
    IO.inspect(analisis)
  end

  def analizar_ventas(ventas_diarias) do
    if map_size(ventas_diarias) == 0 do
      {0, 0, "no hay datos"}
    else
      # Si no está vacío, realizar los cálculos
      total_ventas = Enum.reduce(ventas_diarias, 0, fn {_, ventas_dia}, acc -> acc + ventas_dia end)
      tamano = map_size(ventas_diarias)
      promedio_diario = total_ventas / tamano

      # Obtener el día con la mejor venta
      dia_mejor_venta = Enum.max_by(ventas_diarias, fn {_, ventas_dia} -> ventas_dia end)

      # Devolver los resultados
      {total_ventas, promedio_diario, dia_mejor_venta}
    end


  end
end
Drogueria.main()
