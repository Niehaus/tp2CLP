class Pessoa
    attr_accessor :nome, :endereco
        @@nome = String.new
        @@endereco = String.new

    class InstiationError < RuntimeError
    end

    def initialize
        raise InstiationError, "Pessoa é uma classe abstrata e não pode ser instanciada!"
    end
end