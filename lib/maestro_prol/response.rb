require 'forwardable'

module MaestroProl
  class Response
    include Enumerable
    extend Forwardable
    def_delegators :@savon, :to_s

    def initialize(method, savon)
      @method = method
      @savon = savon
    end

    def result
      @result = doc
    end

    private

    def doc
      @savon.hash[:envelope][:body]["#{@method}_response".to_sym]["#{@method}_result".to_sym][:diffgram]
    end
  end
end

