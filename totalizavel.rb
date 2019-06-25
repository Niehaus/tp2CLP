class Totalizavel
    class InstiationError < RuntimeError
    end

    def initialize
        raise InstiationError, "Totalizavel é uma classe abstrata e não pode ser instanciada diretamente!"
    end
    #define um método abstrato, como fazer isso em ruby?
    def total
        #return valorTotal
    end
end