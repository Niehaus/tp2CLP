require_relative 'interface'
require_relative 'venda'
require_relative 'produto'
require_relative 'cliente'


controlador = Interface.new
puts "Seu comando:"
comando = gets.chomp.to_i
controlador.controller(comando)
