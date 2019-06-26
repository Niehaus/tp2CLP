require_relative 'pessoa'


$rgs_cadastrados = Array.new
$cadastro_clientes = Array.new
class Cliente < Pessoa
    attr_accessor :rg, :dataNasc
    
    def initialize
        self.rg = String.new
        self.dataNasc = Date.new
    end

    def Cliente.busca_cliente(rg)
        $cadastro_clientes.each do |cl|
            if cl.rg == rg
                return cl
            end
        end
    end

    def Cliente.operacoes(codigoComando)

        #Colocar exceção em caso de dados informados errados
        if codigoComando == "Incluir" 
            puts "\n| Área p/ #{codigoComando} Cliente |"   
            @novo_cadastro = Cliente.new
            puts "Informe RG do Cliente: "
            @novo_cadastro.rg = gets.chomp.to_s
            if Interface.existe($rgs_cadastrados, @novo_cadastro.rg) == true
                puts "Cliente já cadastrado"
                Interface.new_op()
            else
                $rgs_cadastrados << @novo_cadastro.rg
                puts "Informe Nome do Cliente: "
                @novo_cadastro.nome = gets.chomp.to_s
                puts "Informe Endereco do Cliente: "
                @novo_cadastro.endereco = gets.chomp.to_s
                puts "Informe Data de Nascimento do Cliente: "
                @novo_cadastro.dataNasc = gets.chomp.to_s
                $cadastro_clientes.push(@novo_cadastro)
                puts "Cliente Cadastrado com Sucesso!\nDeseja Cadastrar outro Cliente? S/N"   
                outroCadastro = gets.chomp.to_s
                if outroCadastro.upcase == "S" 
                    Cliente.operacoes("Incluir") 
                else
                    Interface.new_op()
                end 
            end
            
        elsif codigoComando == "Remover"
            if $cadastro_clientes.length == 0 
                puts "Não há usuário cadastrado!"
                Interface.new_op()
            end   

            puts "Informe o RG do cliente que deseja remover"
            @remove_cliente = gets.chomp.to_s   

            $cadastro_clientes.each_with_index do |cliente, index| 
                if Interface.existe($rgs_cadastrados, @remove_cliente) == true
                    $cadastro_clientes.delete_at(index)
                    puts "Cliente removido com Sucesso!"
                else
                    puts "Cliente não encontrado"  
                end

            end    

            puts "\nDeseja remover um cliente? S/N"   
            outroCadastro = gets.chomp.to_s
            if outroCadastro.upcase == "S" 
                Cliente.operacoes("Remover") 
            else
                Interface.new_op()
            end 

              
        elsif codigoComando == "Alterar"
            if $cadastro_clientes.length == 0 
                puts "Não há usuário cadastrado!"
                Interface.new_op()
            end  

            puts "Informe o RG do cliente que deseja alterar"
            @alterar_cliente = gets.chomp.to_s
            puts $cadastro_clientes
            $cadastro_clientes.each_with_index do |cliente, index| 
                if cliente.rg == @alterar_cliente
                    puts "Informe Nome do Cliente: "
                    cliente.nome = gets.chomp.to_s
                    puts "Informe Endereco do Cliente: "
                    cliente.endereco = gets.chomp.to_s
                    cliente.rg = cliente.rg
                    puts "Informe Data de Nascimento do Cliente: "
                    cliente.dataNasc = gets.chomp.to_s
                    puts "Cliente alterado com Sucesso!\nDeseja alterar dados de outro cliente? S/N"   
                    outroCadastro = gets.chomp.to_s
                    if outroCadastro.upcase == "S" 
                        Cliente.operacoes("Alterar") 
                    else
                        Interface.new_op()
                    end 
                else
                    puts "Não existe este cliente, cadastre-o ou altere outro cliente! "
                    Interface.new_op()
                end
            end

            
            
        elsif codigoComando == "Visualizar"
            puts "1 - Visualizar Todos os Clientes\n" + "2 - Buscar por RG"
            comando = gets.chomp.to_i
            if comando == 1
                $cadastro_clientes.each do |cliente| 
                    puts cliente.nome + " " + cliente.endereco + " " + cliente.rg + " " + cliente.dataNasc 
                end
            elsif comando == 2
                $cadastro_clientes.each_with_index do |cliente, index| 
                    if cliente.rg == @alterar_cliente
                        puts cliente.nome + " " + cliente.endereco + " " + cliente.rg + " " + cliente.dataNasc
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