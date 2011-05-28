module EPP
  class Configuration

    # Hostname of the EPP server
    attr_accessor :host

    # Port on the EPP server, default: 700
    attr_accessor :port

    # Username supplied by the registry
    attr_accessor :username

    # Password supplied by the registry
    attr_accessor :password

    # Certificate to use when connecting
    attr_accessor :certificate

    # Use SSL to connect, default: true
    attr_accessor :ssl

    # Set the connection timeout, default: 60 sec
    attr_accessor :timeout

    def initialize
      @port ||= 700
      @ssl ||= true
      if(!@certificate.nil?)
        @ssl = true
      end
    end

    def [](option)
      send(option)
    end
  end
end
