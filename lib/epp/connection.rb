module EPP
  class Connection

    def initialize(options={})
      [:host, :port, :username, :password,
        :certificate, :ssl, :timeout].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
      connect
    end

    def connect
      @socket = Timeout::timeout(@timeout) { TCPSocket.new(@host, @port) }
      if @ssl
        if @certificate.nil?
          puts "Connecting with SSL" if EPP.debug?
          @socket = SSL::SSLSocket.new(@socket)
        else
          puts "Connecting with SSL and a certificate" if EPP.debug?
          context = SSL::SSLContext.new
          context.key = OpenSSL::PKey::RSA.new(File.open(@certificate))
          context.cert = X509::Certificate.new(File.open(@certificate))
          @socket = SSL::SSLSocket.new(@socket, context)
        end
        @socket.sync_close = true
        @socket.connect
      else
        puts "Connecting without SSL" if EPP.debug?
      end
      unless @login && @password
        read_socket
        return true
      else
        read_socket
        puts "Logging in..." if EPP.debug?
        login
        return true
      end

    end

    def hello
    end

    def hello_raw
      command = '<?xml version="1.0" encoding="UTF-8" standalone="no"?><epp xmlns="urn:ietf:params:xml:ns:epp-1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:ietf:params:xml:ns:epp-1.0 epp-1.0.xsd"> <hello/> </epp>'
      request(command)
    end
    

    def request(msg)
      write_socket(msg)
      return read_socket
    end

    def login
    end

    private

    attr_reader :host, :port, :username, :password, :ssl, :timeout, :certificate
    attr_accessor :socket

    protected

    def read_socket
      length = @socket.read(4).unpack("N").first
      data = @socket.read(length - 4)
      puts "read:\n" + data if EPP.debug?
      data
    end

    def write_socket(xml)
      puts "write:\n" + xml + "SENDING END\n\n" if EPP.debug?
      @socket.write([(xml.size + 4)].pack("N") + xml)
    end
    

  end
end
