begin
  require 'nokogiri'
rescue LoadError
  puts "Unable to load dependencies"
  puts "$ sudo gem install nokogiri"
  raise LoadError, "unable to load dependencies for epp"
end

require "timeout"
require "socket"
require "openssl"
require "term/ansicolor"

include OpenSSL


module EPP

  $:.unshift(File.dirname(__FILE__))  
  require "epp/config"
  require "epp/connection"
  require "epp/builder"

  class << self
    attr_accessor :connection

    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
      self.connection = Connection.new(configuration)
    end

    def debug?
      self.configuration.debug?
    end

  end

end
