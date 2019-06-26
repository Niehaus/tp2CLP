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
        # self.item_venda = ItemVenda.new
    end

    def Venda.operacoes(comando_operacao)
        if comando_operacao == "Incluir" 
            puts "\n| Área p/ #{comando_operacao} venda |"   
            @novo_cadastro = Venda.new
            puts "O vetor de clientes: #{$rgs_cadastrados}"
            puts "Informe o RG do cliente: "
            rg = gets.chomp.to_s
            if Interface.existe($rgs_cadastrados, rg) == false
                puts "Cliente não cadastrado, por favor cadastre-o"
                Cliente.operacoes("Incluir")
            else 
                @novo_cadastro.cliente = Cliente.busca_cliente(rg)
                puts "Informe a data da venda: "
                @novo_cadastro.data = gets.chomp.to_s
                # :TODO verificar como adicionar mais de um elemento na lista
                #@@vendas.push(@novo_cadastro)
                #@item_venda = ItemVenda.new
                loop do 
                    puts "Informe o numero do produto vendido: "
                    codigo = gets.chomp.to_i
                    
                    if Interface.existe($codigos_cadastrados, codigo) == true
                        @item_venda.produto = Produto.busca_produto(codigo)
                        puts "informe a quantidade de produtos vendidos: "
                        @item_venda.quantidade = gets.chomp.to_i
                        @novo_cadastro.itens.push(@item_venda)
                        @@vendas.push(@novo_cadastro)
                        # @novo_cadastro.itens.push(item_venda.produto) 
                    else
                        puts "Produto não cadastrado, por favor cadastre-o"
                        Produto.operacoes("Incluir")
                    end
                    puts "Deseja cadastrar mais um produto? S/N "
                    saida = gets.chomp.to_s
                    if saida.upcase == "N"
                        break
                    end
                end                    

                Interface.new_op()
            end
            

        elsif comando_operacao == "Remover"
            puts "Informe o número da venda que deseja remover"
            remove_venda = gets.chomp.to_s                     
                
            @@vendas.each_with_index do |prod, index| 
                puts @codigos_cadastrados
                if Interface.existe(@codigos_cadastrados, remove_venda) == true
                    @@vendas.delete_at(index)
                    puts "Venda removido com Sucesso!"
                else
                    puts "Venda não encontrado"  
                end

            end    

            puts "\nDeseja remover outra venda? S/N"   
            outra_venda = gets.chomp.to_s
            if outra_venda.upcase == "S" 
                Venda.operacoes("Remover") 
            else
                Interface.new_op()
            end 

              
        elsif comando_operacao == "Alterar"
            puts "Informe o código do produto que deseja alterar"
            codigo_altera = gets.chomp.to_s
            @@venda.each_with_index do |vendas, index| 
                if Interface.existe(@codigos_cadastrados, codigo_altera) == true
                    puts "Informe nome do produto: "
                    vedas.numero = gets.chomp.to_i
                    vendas.itens do |it|
                        puts "Informe o código do produto vendido: "
                        vendas.it = gets.chomp.to_i
                        puts "Informe a quantidade vendida do produto: "
                        vendas.quantidade = gets.chomp.to_i
                    end
                end
            end

            puts "\nDeseja alterar outra venda? S/N"   
            outroCadastro = gets.chomp.to_s
            if outroCadastro.upcase == "S"        
                Venda.operacoes("Alterar") 
            else
                Interface.new_op()
            end 
            
        elsif comando_operacao == "Visualizar"
            puts "1 - Visualizar todas as vendas\n" + "2 - Buscar por número"
            comando = gets.chomp.to_i
            if comando == 1
                
                @@vendas.each do |vendido| 
                    puts "Cliente: #{vendido.cliente.nome}, rg: #{vendido.cliente.rg}"
                    puts "Data da venda: #{vendido.data}"
                    puts "ITEM #{vendido.itens}"
                    vendido.itens.each do |it|
                        puts it.produto.valor 
                        puts it.produto.nome
                        puts it.produto.codigo
                        puts it.quantidade
                    end
                    
                end
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
        @@venda.each do |cl|
            if cl.codigo == codigo
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