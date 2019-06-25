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
            puts "produto insere"
            Produto.operacoes(codigoComando)
        when 3
            #Operações com Venda
            Venda.operacoes(codigoComando)
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

    def Interface.existe(vetor, valor)
        if vetor.include?(valor)
            return true
        else 
            return false
        end
    end

end