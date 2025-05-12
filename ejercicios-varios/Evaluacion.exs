defmodule Evaluacion do
  def main() do
    calificaciones = %{
      "Juan" => [7, 8, 9],
      "Ana" => [4, 5, 6],
      "Pedro" => [10, 9, 8]
    }
    aux=evaluar_proyecto(calificaciones, "Jusaan")
    IO.inspect(aux)
  end


  def evaluar_proyecto(calificaciones, estudiante) do
    # Verificar si el estudiante está en el mapa
    case Map.get(calificaciones, estudiante) do
      nil ->
        {0, "No encontrado"}  # Si el estudiante no está, devolver (0, "No encontrado")

      calificaciones_lista ->
        # Calcular el promedio de las calificaciones
        promedio = Enum.sum(calificaciones_lista) / length(calificaciones_lista)

        # Determinar el estado según el promedio
        estado = if promedio >= 6, do: "Aprobado", else: "Reprobado"

        {promedio, estado}  # Retornar el promedio y el estado
    end
  end

end
Evaluacion.main()
