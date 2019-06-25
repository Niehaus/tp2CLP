$codigos_cadastrados
class Produto
    attr_accessor :codigo, :nome, :valor
    @@produtos = Array.new 
    $codigos_cadastrados = Array.new

    def initialize
        self.codigo = Integer
        self.nome = ""
        self.valor = Float
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
                $codigos_cadastrados << @novo_cadastro.codigo
                puts "Informe Nome do Produto: "
                @novo_cadastro.nome = gets.chomp.to_s
                puts "Informe o valor do Produto: "
                @novo_cadastro.valor = gets.chomp.to_f
                
                @@produtos.push(@novo_cadastro)
                puts "Produto Cadastrado com Sucesso!\n Deseja Cadastrar outro produto? S/N"   
                outro_cadastro = gets.chomp.to_s
                if outro_cadastro.upcase == "S" 
                    Produto.operacoes("Incluir") 
                else
                    Interface.new_op()
                end #if no volta pras operações com cliente
            end
            
        elsif comando_operacao == "Remover"
            puts "Informe o código do produto que deseja remover"
            @remove_produto = gets.chomp.to_s                     
                
            @@produtos.each_with_index do |prod, index| 
                puts $codigos_cadastrados
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
                if Interface.existe($codigos_cadastrados, @codigo_altera) == true
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
end