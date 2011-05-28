module EPP

  @@default_params = {
    :host => 'epp.iis.se',
    :port => "378",
    :username => nil,
    :password => nil,
    :certificate => nil,
    :debug => nil,
    :logger => nil
  }

  class Base

    def initialize(host=nil, port=nil, opts={})
    end


    protected
      def setup(opts)

        @logger = opts[:logger] || nil

      end
  end

end
