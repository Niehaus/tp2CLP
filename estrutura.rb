require 'date'

class Pessoa
    attr_accessor :nome, :endereco
    def initialize
        self.nome
        self.endereco
    end
end

class Cliente < Pessoa
    attr_accessor :rg, :dataNasc
    def initialize
        self.rg = ""
        self.dataNasc = Date.new
    end

    def Cliente.incluir #método de classe para ser usado sem ter que instanciar
        
    end

    def Cliente.remover
        
    end

    def Cliente.visualizarDados
        
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
          puts "1 - Inclusão\n" + "2 - Alteração\n" + "3 - Remoção\n" + "4 - Visualização dos Dados"
    end

    def wichOne(comando)
        case comando
        when 1
            puts "cliente"
        when 2

        when 3

        else
        end
    end
    #Controlador do menu
    def controller(comando)
        case comando
        when 1
            #Inclusão
            puts "Deseja incluir\n" + "1 - Cliente\n" + "2 - Pruduto\n" + "3 - Cadastrar Venda"
            comando2 = gets.chomp.to_i
            wichOne(comando2)
            #Cliente.incluir()
        when 2
            #Alteração
            puts "quero alterar"
        when 3
            #Remoção
            puts "quero remover"
        when 4
            #Visualização dos dados
            puts "quero visualizar"
        else
            "Este comando não existe"
        end
    end

end