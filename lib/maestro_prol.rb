require "savon"
require "maestro_prol/base"
require "maestro_prol/order"
require "maestro_prol/response"

module MaestroProl
  def self.config!(config)
    @config = config
  end

  def self.config
    @config
  end
end
