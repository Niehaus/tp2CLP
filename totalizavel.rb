class Totalizavel
    class InstiationError < RuntimeError
    end

    def initialize
        raise InstiationError, "Totalizavel é uma classe abstrata e não pode ser instanciada diretamente!"
    end

    def total
        #return valorTotal
    end
end