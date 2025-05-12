defmodule Matriuska do
  def main() do
    n=4
    imprimir_matriuska(n)
  end

  def imprimir_matriuska(n) when n >0 do

    IO.puts "Abriendo Matriuska número #{n}"  
    imprimir_matriuska(n - 1)
    IO.puts "Cerrando Matriuska número #{n}"
4
  end



end
Matriuska.main()
