require_relative 'totalizavel'
require_relative 'itemvenda'
require 'date'


class Venda < Totalizavel 
    attr_accessor :numero, :data, :cliente, :itens
    @@vendas = Array.new

    def initialize
        self.numero = Integer
        self.data = Date.new
        self.cliente = Cliente.new
        self.itens = Array.new
    end

    def Venda.operacoes(comando_operacao)
        if comando_operacao == "Incluir" 
            puts "\n| Área p/ #{comando_operacao} venda |"   
            @novo_cadastro = Venda.new
            puts "Informe o código da venda"
            @novo_cadastro.numero = gets.chomp.to_i
            puts "Informe o RG do cliente: "
            rg = gets.chomp.to_s
            if Interface.existe($rgs_cadastrados, rg) == false
                puts "Cliente não cadastrado, por favor cadastre-o"
                Cliente.operacoes("Incluir")
            else 
                @novo_cadastro.cliente = Cliente.busca_cliente(rg)
                puts "Informe a data da venda: "
                @novo_cadastro.data = gets.chomp.to_s
                loop do 
                    @item_venda = ItemVenda.new
                    puts "Informe o numero do produto vendido: "
                    num = gets.chomp.to_i
                    
                    if Interface.existe($codigos_cadastrados, num) == true
                        @item_venda.produto = Produto.busca_produto(num)
                        puts "informe a quantidade de produtos vendidos: "
                        @item_venda.quantidade = gets.chomp.to_i
                        @novo_cadastro.itens.push(@item_venda)
                    else
                        puts "Produto não cadastrado, por favor cadastre-o"
                        Produto.operacoes("Incluir")
                    end
                    puts "\nDeseja cadastrar mais um produto? S/N "
                    saida = gets.chomp.to_s
                    if saida.upcase == "N"
                        break
                    end
                end     
                @@vendas.push(@novo_cadastro)
                puts "Venda efetuada com sucesso!"
                puts "\n\nDeseja adicionar outra venda? S/N"   
                outra_venda = gets.chomp.to_s
                if outra_venda.upcase == "S" 
                    Venda.operacoes("Incluir") 
                else
                    Interface.new_op()
                end 
            end
            

        elsif comando_operacao == "Remover"
            if @@vendas.length == 0
                puts "Não há vendas cadastradas!"
                Interface.new_op()
            end

            puts "Informe o número da venda que deseja remover"
            remove_venda = gets.chomp.to_s                     
                
            @@vendas.each_with_index do |prod, index| 
                if Interface.existe(@codigos_cadastrados, remove_venda) == true
                    @@vendas.delete_at(index)
                    puts "Venda removido com Sucesso!"
                    puts "\n\nDeseja remover outra venda? S/N"   
                    outra_venda = gets.chomp.to_s
                    if outra_venda.upcase == "S" 
                        Venda.operacoes("Remover") 
                    end 
                else
                    puts "Venda não encontrado!"
                    Interface.new_op()
                end

                Interface.new_op()
            end    

              
        elsif comando_operacao == "Alterar"
            if @@vendas.length == 0
                puts "Não há vendas cadastradas!"
                Interface.new_op()
            end

            puts "Informe o código do produto que deseja alterar"
            codigo_altera = gets.chomp.to_s
            @@venda.each_with_index do |vendas, index| 
                if Interface.existe($codigos_cadastrados, codigo_altera) == true
                    puts "Informe nome do produto: "
                    vedas.numero = gets.chomp.to_i
                    vendas.itens do |it|
                        puts "Informe o código do produto vendido: "
                        vendas.it = gets.chomp.to_i
                        puts "Informe a quantidade vendida do produto: "
                        vendas.quantidade = gets.chomp.to_i
                    end
                    puts "Venda alterada com sucesso! \n\nDeseja alterar outra venda? S/N"   
                    outroCadastro = gets.chomp.to_s
                    if outroCadastro.upcase == "S"        
                        Venda.operacoes("Alterar") 
                    else
                        Interface.new_op()
                    end 
                else
                    puts "Não existe este produto!"
                    Interface.new_op()
                end
            end

            
        elsif comando_operacao == "Visualizar"
             if @@vendas.length == 0
                puts "Não há vendas cadastradas!"
                Interface.new_op()
            end
            puts "1 - Visualizar todas as vendas\n" + "2 - Buscar por número"
            comando = gets.chomp.to_i
            if comando == 1                
                @@vendas.each do |vendido| 
                    puts "Código da venda: #{vendido.numero}"
                    puts "Cliente: #{vendido.cliente.nome}, rg: #{vendido.cliente.rg}"
                    puts "Data da venda: #{vendido.data}"
                    vendido.itens.each do |it|
                        puts "Produto: #{it.produto.nome}, valor: #{it.produto.valor}, codigo: #{it.produto.codigo}, quantidade: #{it.quantidade}, preço total produto: #{it.total()}"
                    end
                    puts "Total da compra: #{vendido.total(vendido.numero)}"
                    puts "----- " * 10
                end
                Interface.new_op()
            elsif comando == 2
                puts "Digite o código do produto que deseja visualizar"
                codigo_visualiza = gets.chomp.to_s
                @@vendas.each do |produto| 
                    if produto.codigo == @codigo_visualiza
                        puts "Cliente: #{vendido.cliente.nome}, rg: #{vendido.cliente.rg}"
                        puts "Data da venda: #{vendido.data}"
                        vendido.itens.each do |it|
                            puts it.produto.valor 
                            puts it.produto.nome
                            puts it.produto.codigo
                            puts it.quantidade
                            puts @@vendas.total(@@vendas.numero)
                        end
                    end
                end
                puts "Deseja visualizar outra venda? S/N"   
                outroCadastro = gets.chomp.to_s
                if outroCadastro.upcase == "S" 
                    Venda.operacoes("Visualizar") 
                else
                    Interface.new_op()
                    
                end 
            else
                puts "comando invalido"
            end

        else
            puts "Comando Inválido. Tente novamente ou 0 para sair."
        end   
    end

    def Venda.busca_venda(codigo)
        @@vendas.each do |cl|
            if cl.numero == codigo
                return cl
            end
        end
    end

    def total(venda)
        obj_venda = Venda.busca_venda(venda)
        resul = 0
        obj_venda.itens.each do |it|
            resul += it.total()
        end
        return resul
    end
end