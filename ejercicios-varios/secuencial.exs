defmodule Proceso do
  @cantida_procesos_internos 5
  def main do
    Benchmark.determinar_tiempo_ejecucion({Proceso, :simulacion, [@cantida_procesos_internos]})
    |> generar_mensaje()
    |> Util.mostrar_mensaje()
  end
  def simulacion (cantidad_procesos_internos) do
    datos_prueba= [{"A", 2500}, {"\tB", 1500}, {"\t\tC", 500}, {"\t\t\tD", 3500}]
    tarea =
      Enum.map(datos_prueba, fn valor -> 
        Task.async(fn -> simulando_proceso(valor, cantidad_procesos_internos) end)
      end)

      Enum.each(tarea, &Task.await(&1, 100_000))
  end
  def simulando_proceso({mensaje, demora}, cantidad_procesos_internos) do
    IO.puts("#{mensaje}->(Inicia)")

    Enum.each(1..cantidad_procesos_internos, fn i ->
      :timer.sleep(demora)
      IO.puts("\t#{mensaje}-#{i}")
    end)

    IO.puts("#{mensaje} -> (Finalizada)")
  end
  def generar_mensaje(tiempo), do: "\nEl tiempo de ejecucion es de #{tiempo} microsegundos"
end
def proceso(mensaje_inicial) do
  spawn(fn -> loop(mensaje_inicial) end)
end

defp loop(mensaje_actual) do
  IO.puts(mensaje_actual)

  receive do
    {:fin, mensaje_final} ->
      IO.puts(mensaje_final)
    {:continuar, nuevo_mensaje} ->
      loop(nuevo_mensaje)
  end
end
Proceso.main()
