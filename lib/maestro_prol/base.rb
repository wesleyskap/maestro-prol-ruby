module MaestroProl
  class Base
    attr_reader :response

    class << self
      %w(resource_name collection_name).each do |attribute|
        define_method "#{attribute}=" do |param|
          instance_variable_set "@#{attribute}", param
        end

        define_method "#{attribute}" do
          instance_variable_get "@#{attribute}"
        end
      end

      def collection_name
        @collection_name ||= "#{resource_name}s"
      end

      def call(method, params)
        Response.new method, api.call(method, message: params)
      end

      def create(method, params)
        new response: call(method, params)
      end
    end

    def initialize(params)
      params.each do |key, value|
        instance_variable_set "@#{key}", value
        define_singleton_method(key) { instance_variable_get "@#{key}" }
      end
    end

    private

    def self.api
      Savon.client wsdl: "#{endpoint}/MaestroWebService.asmx?wsdl", log: MaestroProl.config['log'], read_timeout: 120, open_timeout: 120 do
        convert_request_keys_to :camelcase
      end
    end

    def self.endpoint
      MaestroProl.config['ws']['endpoint']
    end
  end
end
