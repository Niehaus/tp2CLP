require_relative 'totalizavel'
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
            puts "O vetor de clientes: #{$rgs_cadastrados}"
            puts "Informe o RG do cliente: "
            rg = gets.chomp.to_s
            if Interface.existe($rgs_cadastrados, rg) == false
                puts "Cliente não cadastrado, por favor cadastre o cliente"
                Cliente.operacoes("Incluir")
            else #continuar daqui
                @novo_cadastro.cliente = @novo_cadastro.cliente.rg
                puts "Informe o número do produto: "
                @novo_cadastro.numero = gets.chomp.to_i
                puts "Informe a data da venda: "
                @novo_cadastro.data = gets.chomp.to_s
                item_venda = ItemVenda.new
                loop do 
                    puts "Informe o item vendidos: (Caso queira sair digite 0)"
                    @novo_cadastro.itens = gets.chomp.to_i
                    if @novo_cadastro.item == 0
                        break
                    end
                    puts "informe o produto: "
                    item_venda.produto = gets.chomp
                    item_venda = @novo_cadastro
                    @novo_cadastro.itens.push(item_venda)
                end                    
                
                @@vendas.push(@novo_cadastro)
                Interface.new_op()
            end
            

        elsif comando_operacao == "Remover"
            puts "Informe o código do produto que deseja remover"
            @remove_produto = gets.chomp.to_s                     
                
            @@produtos.each_with_index do |prod, index| 
                puts @codigos_cadastrados
                if Interface.existe(@codigos_cadastrados, @remove_produto) == true
                    @@produtos.delete_at(index)
                    puts "Produto removido com Sucesso!"
                else
                    puts "Produto não encontrado"  
                end

            end    

            puts "\nDeseja remover outro produto? S/N"   
            outro_cadastro = gets.chomp.to_s
            if outro_cadastro.upcase == "S" 
                Produto.operacoes("Remover") 
            else
                Interface.new_op()
            end 

              
        elsif comando_operacao == "Alterar"
            puts "Informe o código do produto que deseja alterar"
            @codigo_altera = gets.chomp.to_s
            @@produtos.each_with_index do |produto, index| 
                if Interface.existe(@codigos_cadastrados, @codigo_altera) == true
                    puts "Informe novo nome do produto: "
                    produto.nome = gets.chomp.to_s
                    puts "Informe novo preço do produto: "
                    produto.endereco = gets.chomp.to_s
                    produto.rg = cliente.rg
                    @@produtos.push(produto)
                end
            end

            puts "\nDeseja alterar outro produto? S/N"   
            outroCadastro = gets.chomp.to_s
            if outroCadastro.upcase == "S"        
                Cliente.operacoes("Alterar") 
            else
                Interface.new_op()
            end 
            
        elsif comando_operacao == "Visualizar"
            puts "1 - Visualizar Todos os produtos\n" + "2 - Buscar por código"
            comando = gets.chomp.to_i
            if comando == 1
                @@produtos.each do |produto| 
                    puts produto.nome + " " + produto.codigo + " " + produto.valor 
                end
            elsif comando == 2
                puts "Digite o código do produto que deseja visualizar"
                codigo_visualiza = gets.chomp.to_s
                @@produtos.each do |produto| 
                    if produto.codigo == @codigo_visualiza
                        puts produto.nome + " " + produto.codigo + " " + produto.valor
                    end
                end
            else
                puts "comando invalido"
            end

            puts "Deseja visualizar outro cliente? S/N"   
            outroCadastro = gets.chomp.to_s
            if outroCadastro.upcase == "S" 
                Cliente.operacoes("Visualizar") 
            else
                Interface.new_op()
                
            end 

        else
            puts "Comando Inválido. Tente novamente ou 0 para sair."
        end   
    end

    def total
        # deve calcular a soma dos totais de cada item 
    end
end