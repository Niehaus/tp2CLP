$codigos_cadastrados = Array.new

class Produto
    attr_accessor :codigo, :nome, :valor
    attr_reader :codigo, :nome, :valor
    attr_writer :codigo, :nome, :valor

    @@produtos = Array.new 

    def initialize
        self.codigo = Integer
        self.nome = ""
        self.valor = Float
    end

    def Produto.busca_produto(codigo)
        @@produtos.each do |cl|
            if cl.codigo == codigo
                return cl
            end
        end
    end

    def Produto.operacoes(comando_operacao)
        if comando_operacao == "Incluir" 
            puts "\n| Área p/ #{comando_operacao} produto |"   
            @novo_cadastro = Produto.new
            puts "Informe o codigo do produto: "
            @novo_cadastro.codigo = gets.chomp.to_i
            if Interface.existe($codigos_cadastrados, @novo_cadastro.codigo) == true
                puts "Produto já cadastrado"
                Interface.new_op()
            else
                $codigos_cadastrados.push(@novo_cadastro.codigo)
                puts "Informe Nome do Produto: "
                @novo_cadastro.nome = gets.chomp.to_s
                puts "Informe o valor do Produto: "
                @novo_cadastro.valor = gets.chomp.to_f
                
                @@produtos.push(@novo_cadastro)
                puts "Produto Cadastrado com Sucesso!\nDeseja Cadastrar outro produto? S/N"   
                outro_cadastro = gets.chomp.to_s
                if outro_cadastro.upcase == "S" 
                    Produto.operacoes("Incluir") 
                else
                    Interface.new_op()
                end #if no volta pras operações com cliente
            end
            
        elsif comando_operacao == "Remover"
            # Verifica se existe algum produto para poder remover
            if @@produtos.length == 0
                puts "Não existe nenhum produto cadastrado"
                Interface.new_op()
            end   

            puts "Informe o código do produto que deseja remover"
            @remove_produto = gets.chomp.to_i  
                
            @@produtos.each_with_index do |prod, index| 
                if Interface.existe($codigos_cadastrados, @remove_produto) == true
                    @@produtos.delete_at(index)
                    puts "Produto removido com Sucesso!"
                else
                    puts "Produto não encontrado"  
                end

            end    

            puts "\nDeseja remover um produto? S/N"   
            outro_cadastro = gets.chomp.to_s
            if outro_cadastro.upcase == "S" 
                Produto.operacoes("Remover") 
            else
                Interface.new_op()
            end 

              
        elsif comando_operacao == "Alterar"
            if @@produtos.length == 0
                puts "Não existe nenhum produto cadastrado"
                Interface.new_op()
            end
            puts "Informe o código do produto que deseja alterar"
            @codigo_altera = gets.chomp.to_i

            @@produtos.each_with_index do |produto, index| 
                if Interface.existe($codigos_cadastrados, @codigo_altera) == true
                    puts "Informe novo nome do produto: "
                    produto.nome = gets.chomp.to_s
                    puts "Informe novo preço do produto: "
                    produto.valor = gets.chomp.to_f
                    puts "\nDeseja alterar outro produto? S/N"   
                    outroCadastro = gets.chomp.to_s
                    if outroCadastro.upcase == "S"        
                        Cliente.operacoes("Alterar") 
                    else
                        Interface.new_op()
                    end 
                else
                    puts "Produto não existente no sistema, mude outro produto ou cadertre-o "
                    Interface.new_op()
                end
            end

    
        elsif comando_operacao == "Visualizar"
            puts "1 - Visualizar Todos os produtos\n" + "2 - Buscar por código"
            comando = gets.chomp.to_i
            if comando == 1
                @@produtos.each do |produto| 
                    puts "Nome: " + produto.nome + "\nCódigo do produto: " + produto.codigo.to_s + "\nValor: " + produto.valor.to_s
                    puts "----- " * 10
                end
            elsif comando == 2
                puts "Digite o código do produto que deseja visualizar"
                codigo_visualiza = gets.chomp.to_i
                
                @@produtos.each do |produto| 
                    if Interface.existe($codigos_cadastrados, codigo_visualiza) == true
                        puts "Nome: #{produto.nome} \nCódigo do produto: #{produto.codigo.to_s} \nValor: #{produto.valor.to_s}"
                        puts "Deseja visualizar outro produto? S/N"   
                        outroCadastro = gets.chomp.to_s
                        if outroCadastro.upcase == "S" 
                            Produto.operacoes("Visualizar") 
                        end
                    else
                        puts "produto não encontrado no sistema"
                    end
                end
            else
                puts "comando invalido"
            end
            Interface.new_op()             

        else
            puts "Comando Inválido. Tente novamente ou 0 para sair."
        end   
    end
end