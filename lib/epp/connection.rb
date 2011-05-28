module EPP
  class Connection

    def initialize(options={})
      [:host, :port, :username, :password,
        :certificate, :ssl, :timeout].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
    end

    def connect
      @socket = Timeout::timeout(@timeout) { TCPSocket.new(@server, @port) }
      if

    def hello
    end

    def request
    end

      defresponse
    end

    private

    attr_reader :host
  end
end
