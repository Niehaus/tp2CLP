require 'date'

class Pessoa
    attr_accessor :nome, :endereco
        @@nome = String.new
        @@endereco = String.new
end

class Verificacao
    def Verificacao.existe(vetor, valor)
        if vetor.include?(valor)
            return true
        else 
            return false
        end
    end
end


class Cliente < Pessoa
    attr_accessor :rg, :dataNasc
    @@cadastroClientes = Array.new 
    @@rgs_cadastrados = Array.new
    def initialize
        self.rg = String.new
        self.dataNasc = Date.new
    end

    def Cliente.operacoes(codigoComando)

        #Colocar exceção em caso de dados informados errados
        if codigoComando == "Incluir" 
            puts "\n| Área p/ #{codigoComando} Cliente |"   
            @novoCadastro = Cliente.new
            puts "Informe RG do Cliente: "
            @novoCadastro.rg = gets.chomp.to_s
            if Verificacao.existe(@@rgs_cadastrados, @novoCadastro.rg) == true
                puts "Cliente já cadastrado"
                Interface.new_op()
            else
                @@rgs_cadastrados << @novoCadastro.rg
                puts "Informe Nome do Cliente: "
                @novoCadastro.nome = gets.chomp.to_s
                puts "Informe Endereco do Cliente: "
                @novoCadastro.endereco = gets.chomp.to_s
                puts "Informe Data de Nascimento do Cliente: "
                @novoCadastro.dataNasc = gets.chomp.to_s
                @@cadastroClientes.push(@novoCadastro)
                puts "Cliente Cadastrado com Sucesso!\n Deseja Cadastrar outro Cliente? S/N"   
                outroCadastro = gets.chomp.to_s
                if outroCadastro.upcase == "S" 
                    Cliente.operacoes("Incluir") 
                else
                    Interface.new_op()
                end #if no volta pras operações com cliente
            end
            
        elsif codigoComando == "Remover"
            puts "Informe o RG do cliente que deseja remover"
            @remove_cliente = gets.chomp.to_s                     
                
            @@cadastroClientes.each_with_index do |cliente, index| 
                if Verificacao.existe(@@rgs_cadastrados, @remove_cliente) == true
                    @@cadastroClientes.delete_at(index)
                    puts "Cliente removido com Sucesso!"
                else
                    puts "Cliente não encontrado"  
                end

            end    
            
            puts "\nDeseja remover outro cliente? S/N"   
            outroCadastro = gets.chomp.to_s
            if outroCadastro.upcase == "S" 
                Cliente.operacoes("Remover") 
            else
                Interface.new_op()
            end 

              
        elsif codigoComando == "Alterar"
            puts "Informe o RG do cliente que deseja alterar"
            @alterar_cliente = gets.chomp.to_s
            @@cadastroClientes.each_with_index do |cliente, index| 
                if cliente.rg == @alterar_cliente
                    puts "Informe Nome do Cliente: "
                    cliente.nome = gets.chomp.to_s
                    puts "Informe Endereco do Cliente: "
                    cliente.endereco = gets.chomp.to_s
                    cliente.rg = cliente.rg
                    puts "Informe Data de Nascimento do Cliente: "
                    cliente.dataNasc = gets.chomp.to_s
                    @@cadastroClientes.push(cliente)
                end
            end

            puts "Cliente removido com Sucesso!\n Deseja remover outro cliente? S/N"   
            outroCadastro = gets.chomp.to_s
            if outroCadastro.upcase == "S" 
                Cliente.operacoes("Alterar") 
            else
                Interface.new_op()
            end 
            
        elsif codigoComando == "Visualizar"
            puts "1 - Visualizar Todos os Clientes\n" + "2 - Buscar por RG"
            comando = gets.chomp.to_i
            if comando == 1
                @@cadastroClientes.each do |cliente| 
                    puts cliente.nome + " " + cliente.endereco + " " + cliente.rg + " " + cliente.dataNasc 
                end
            elsif comando == 2
                @@cadastroClientes.each_with_index do |cliente, index| 
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

class Produto
    attr_accessor :codigo, :nome, :valor
    def initialize
        self.codigo = Integer.new
        self.nome = ""
        self.valor = Float.new
    end

end

class Totalizavel
    #define um método abstrato, como fazer isso em ruby?
    def total
        
        return valorTotal
    end
end

class Venda < Totalizavel 
    attr_accessor :numero, :data, :cliente, :itens
    def initialize
        self.numero = Integer.new
        self.data = Date.new
        self.cliente = Cliente.new
        self.itens = Array.new
    end

    def total
        #deve calcular a soma dos totais de cada item 
    end
end

class ItemVenda < Totalizavel
    def initialize
        self.numero = Integer.new
        self.produto = Produto.new
        self.valor = Float.new #o valor é copiado do valor do produto no momento da venda. 
        self.quantidade = Integer.new
    end
    
    def total
        #deve calcular o valor vezes a quantidade
    end
end

class Interface
    def initialize
          puts "=" * 23
          puts "| Sistema de Registro |"
          puts "=" * 23  
          puts "Insira o nº correspondendo à opção desejada:"
          puts "1 - Inclusão\n" + "2 - Alteração\n" + "3 - Remoção\n" + "4 - Visualização dos Dados\n" + "0 - Sair"
    end

    def wichOne(comando,codigoComando)
        case comando
        when 1 
            #Operações com Cliente
            Cliente.operacoes(codigoComando) 
        when 2
            #Operações com Produto
            puts "\n| Área p/ #{codigoComando} Produto |"
        when 3
            #Operações com Venda
            puts "\n| Área p/ #{codigoComando} Vendas |"
        else
            puts "Comando inválido. Insira um comando válido:"
            puts "1 - Inclusão\n" + "2 - Alteração\n" + "3 - Remoção\n" + "4 - Visualização dos Dados\n" + "0 - Sair"
            comando = gets.chomp.to_i
            controller(comando)
        end
    end
    #Controlador do menu
    def controller(comando)
        case comando
        when 1
            #Inclusão
            puts "Deseja Incluir\n" + "1 - Cliente\n" + "2 - Produto\n" + "3 - Cadastrar Venda"
            comando2 = gets.chomp.to_i
            wichOne(comando2,"Incluir")
            #Cliente.incluir()
        when 2
            #Alteração
            puts "Deseja Alterar\n" + "1 - Cadastro de Cliente\n" + "2 - Cadastro de Produto\n" + "3 - Cadastro de Venda"
            comando2 = gets.chomp.to_i
            wichOne(comando2,"Alterar")
        when 3
            #Remoção
            puts "Deseja Remover\n" + "1 - Cliente\n" + "2 - Produto\n" + "3 - Cadastrar Venda"
            comando2 = gets.chomp.to_i
            wichOne(comando2,"Remover")
        when 4
            #Visualização dos dados
            puts "Deseja Visualizar\n" + "1 - Cadastro de Cliente\n" + "2 - Cadastro de Produto\n" + "3 - Cadastro de Venda"
            comando2 = gets.chomp.to_i
            wichOne(comando2,"Visualizar")
        when 0 
            exit!
        else
            puts "Comando inválido. Insira um comando válido:"
            puts "1 - Inclusão\n" + "2 - Alteração\n" + "3 - Remoção\n" + "4 - Visualização dos Dados\n" + "0 - Sair"
            comando = gets.chomp.to_i
            controller(comando)
        end
    end

    def Interface.new_op()
        puts "Deseja realizar outra operação? S/N"   
        outra_operacao = gets.chomp.to_s
        if outra_operacao.upcase == "S" 
            controlador = Interface.new
            puts "Seu comando:"
            comando = gets.chomp.to_i
            controlador.controller(comando) 
        else 
            puts "Obrigada por utilizar o sistema"
        end
    end

end