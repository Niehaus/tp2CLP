require_relative 'totalizavel'
require_relative 'produto'

class ItemVenda < Totalizavel
	attr_accessor :produto, :quantidade 
    def initialize
        self.produto = Produto.new
        self.quantidade = Integer
    end
    
    def total
        return produto.valor * quantidade
    end
end