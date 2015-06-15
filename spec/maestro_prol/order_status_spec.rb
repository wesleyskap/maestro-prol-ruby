require 'spec_helper'

describe MaestroProl::Order do
  describe ".status" do
    let(:order_id) { '67399' }
    it "should return order" do
      VCR.use_cassette('order_precessed') do
        pedido_status = MaestroProl::Order.status(order: order_id)
        expect(pedido_status[:pedido]).to eq(order_id)
        expect(pedido_status[:status]).to eq("Em Acabamento")
        expect(pedido_status[:processamento]).to eq("18/05/2015")
        expect(pedido_status[:prev_entrega]).to eq("21/05/2015")
      end
    end

    it "should return order unprocessed" do
      VCR.use_cassette('order_unprocessed') do
        pedido_status = MaestroProl::Order.status(order: '00001')
        expect(pedido_status[:status]).to eql("Pedido não processado!")
        expect(pedido_status[:processamento]).to be_nil
        expect(pedido_status[:prev_entrega]).to be_nil
      end
    end

    it "should return processed by ean and order number" do
      VCR.use_cassette('order_by_ean_and_number') do
        ean_number = "9781608427727"
        pedido = MaestroProl::Order.status_by_ean_and_order(ean: ean_number, order: order_id)
        expect(pedido[:ean]).to eq(ean_number)
        expect(pedido[:pedido]).to eq(order_id)
      end
    end
  end

  describe ".opened" do
    it "should return opened list" do
      VCR.use_cassette('order_opened') do
        opened = MaestroProl::Order.opened
        expect(opened.first).to have_key(:pedido_id)
        expect(opened.first).to have_key(:status)
        expect(opened.first).to have_key(:prev_entrega)
        expect(opened.first).to have_key(:processamento)
      end
    end
  end
end
