require_relative 'estrutura'

controlador = Interface.new
puts "Seu comando:"
comando = gets.chomp.to_i
controlador.controller(comando)
