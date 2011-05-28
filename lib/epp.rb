begin
  require 'nokogiri'
rescue LoadError
  puts "Unable to load dependencies"
  puts "$ sudo gem install nokogiri"
  raise LoadError, "unable to load dependencies for epp"
end

require "epp/config"
require "epp/connection"

module EPP

  class << self
    attr_accessor :connection

    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
      self.connection = Connection.new(configuration)
    end

  end

end
