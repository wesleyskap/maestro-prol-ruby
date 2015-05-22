module MaestroProl
  class Order < Base
    def self.status(order:)
      call(:status_pedido, { 'pedido' => order }).result[:document_element][:retorno_maestro]
    end

    def self.opened
      call(:lista_pedidos_em_aberto, {}).result[:retorno_maestro]
    end

    def self.status_by_ean_and_order(ean:, order:)
      call(:consulta_ean_pedido, { 'pedido' => order, 'ean' => ean}).result[:document_element][:retorno_maestro]
    end
  end
end
