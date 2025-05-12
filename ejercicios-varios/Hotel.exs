defmodule Hotel do
  # Definición de las estructuras
  defmodule Cliente do
    defstruct nombre: "", edad: 0, altura: 0.0
  end

  defmodule Habitacion do
    defstruct numero: 0, tipo: :sencilla
  end

  defmodule Reserva do
    defstruct codigo: "",
              fecha_reserva: "",
              fecha_entrada: "",
              total: 0.0,
              tipo_habitacion: :sencilla,
              cliente: %Cliente{},
              habitaciones: []
  end

  # Función para crear una nueva reserva
  def nueva_reserva(codigo, fecha_reserva, fecha_entrada, total, tipo_habitacion, cliente, habitaciones) do
    %Reserva{
      codigo: codigo,
      fecha_reserva: fecha_reserva,
      fecha_entrada: fecha_entrada,
      total: total,
      tipo_habitacion: tipo_habitacion,
      cliente: cliente,
      habitaciones: habitaciones
    }
  end

  # 2. Buscar reservas por nombre de cliente
  def buscar_reservas_por_cliente(reservas, nombre_cliente) do
    Enum.filter(reservas, fn reserva ->
      String.downcase(reserva.cliente.nombre) == String.downcase(nombre_cliente)
    end)
  end

  # 3. Contar reservas con total superior a un valor usando divide y vencerás
  # y aprovechando la función del punto 2
  def contar_reservas_caras([], _valor_minimo, _nombre_cliente), do: 0
  def contar_reservas_caras([reserva], valor_minimo, nombre_cliente) do
    # Primero filtramos por cliente (si se especifica)
    reservas_filtradas = if nombre_cliente != nil do
      buscar_reservas_por_cliente([reserva], nombre_cliente)
    else
      [reserva]
    end

    # Luego verificamos el total
    case reservas_filtradas do
      [r] -> if r.total > valor_minimo, do: 1, else: 0
      [] -> 0
    end
  end
  def contar_reservas_caras(reservas, valor_minimo, nombre_cliente \\ nil) do
    mitad = div(length(reservas), 2)
    {primera_mitad, segunda_mitad} = Enum.split(reservas, mitad)

    contar_reservas_caras(primera_mitad, valor_minimo, nombre_cliente) +
    contar_reservas_caras(segunda_mitad, valor_minimo, nombre_cliente)
  end

  # 4. Calcular promedio de edad de forma recursiva
  def promedio_edad(reservas) do
    {suma, cantidad} = sumar_edades(reservas, 0, 0)
    if cantidad > 0, do: suma / cantidad, else: 0
  end

  defp sumar_edades([], suma, cantidad), do: {suma, cantidad}
  defp sumar_edades([reserva | resto], suma, cantidad) do
    sumar_edades(resto, suma + reserva.cliente.edad, cantidad + 1)
  end

  # Función para mostrar las reservas
  def mostrar_reserva(%Reserva{} = reserva) do
    habitaciones_str = Enum.map_join(reserva.habitaciones, ", ", fn h ->
      "#{h.numero}-#{h.tipo}"
    end)

    IO.puts """
    Código: #{reserva.codigo}
    Fecha reserva: #{reserva.fecha_reserva}
    Fecha entrada: #{reserva.fecha_entrada}
    Total: #{reserva.total}
    Tipo habitación: #{reserva.tipo_habitacion}
    Cliente: #{reserva.cliente.nombre} (#{reserva.cliente.edad} años, #{reserva.cliente.altura}m)
    Habitaciones: #{habitaciones_str}
    """
  end

  # Función para crear datos de ejemplo
  def crear_datos_ejemplo do
    [
      nueva_reserva(
        "R001",
        "2025-04-15",
        "2025-04-20",
        250.50,
        :sencilla,
        %Cliente{nombre: "Ana García", edad: 35, altura: 1.65},
        [%Habitacion{numero: 101, tipo: :sencilla}]
      ),
      nueva_reserva(
        "R002",
        "2025-04-16",
        "2025-04-22",
        350.00,
        :doble,
        %Cliente{nombre: "Pedro López", edad: 42, altura: 1.78},
        [%Habitacion{numero: 201, tipo: :doble}, %Habitacion{numero: 202, tipo: :doble}]
      ),
      nueva_reserva(
        "R003",
        "2025-04-18",
        "2025-04-23",
        150.75,
        :sencilla,
        %Cliente{nombre: "Ana García", edad: 35, altura: 1.65},
        [%Habitacion{numero: 102, tipo: :sencilla}]
      ),
      nueva_reserva(
        "R004",
        "2025-04-19",
        "2025-04-25",
        450.00,
        :doble,
        %Cliente{nombre: "Laura Martínez", edad: 28, altura: 1.70},
        [%Habitacion{numero: 203, tipo: :doble}]
      )
    ]
  end

  # Función principal para demostrar el funcionamiento
  def ejecutar_ejemplo do
    # Crear datos de ejemplo
    reservas = crear_datos_ejemplo()
    IO.puts "== Datos de ejemplo creados =="

    # Buscar reservas por nombre de cliente
    nombre_buscar = "Ana García"
    IO.puts "\n== Reservas de #{nombre_buscar} =="
    reservas_cliente = buscar_reservas_por_cliente(reservas, nombre_buscar)
    Enum.each(reservas_cliente, &mostrar_reserva/1)

    # Contar reservas con total superior a un valor usando la función del punto 2
    valor_minimo = 300.0
    IO.puts "\n== Reservas totales con total superior a #{valor_minimo} =="
    cantidad_total = contar_reservas_caras(reservas, valor_minimo)
    IO.puts "Cantidad total: #{cantidad_total}"

    # Contar reservas de un cliente específico con total superior a un valor
    IO.puts "\n== Reservas de #{nombre_buscar} con total superior a #{valor_minimo} =="
    cantidad_cliente = contar_reservas_caras(reservas, valor_minimo, nombre_buscar)
    IO.puts "Cantidad para #{nombre_buscar}: #{cantidad_cliente}"

    # Calcular promedio de edad
    IO.puts "\n== Promedio de edad de los clientes =="
    promedio = promedio_edad(reservas)
    IO.puts "Promedio: #{promedio} años"
  end
end

# Para ejecutar el ejemplo:
# Hotel.ejecutar_ejemplo()
