require 'rubygems'
require 'bundler/setup'
require 'maestro_prol'
require 'pry'
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
end

MAESTRO_CONFIG = YAML.load_file("spec/config.yml")
MaestroProl.config! 'ws' => MAESTRO_CONFIG['ws']
