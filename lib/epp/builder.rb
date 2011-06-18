require "nokogiri"

module EPP

  include Nokogiri::XML

  class Builder < Nokogiri::XML::Builder
    
    def initialize
      super
    end

    def epp(&block)
     tag!("epp", 
          'xmlns' => "urn:ietf:params:xml:ns:epp-1.0",
          #'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
          'xsi:schemaLocation' => "urn:ietf:params:xml:ns:epp-1.0 epp-1.0.xsd",
          &block
         ) 
    end

    def domain(&block)
      epp do
        command do
            tag!("domain")
        end
      end
    end

    def login(username, password)
      epp do
        tag!("command") do
          tag!("login") do
            #clId username
            #password password
            tag!("options") do
              tag!("version","1.0")
              tag!("lang", "en")
            end
            tag!("svcs") do
              tag!("objURI", "urn:ietf:params:xml:ns:domain-1.0")
              tag!("objURI", "urn:ietf:params:xml:ns:contact-1.0")
              tag!("objURI", "urn:ietf:params:xml:ns:host-1.0")
              tag!("svcExtension") do
                tag!("extURI","urn:ietf:params:xml:ns:secDNS-1.0")
                tag!("extURI","urn:se:iis:xml:epp:iis-1.1")
              end
            end
          end
          tag!("cltrid", cltrid)
        end
      end
    end
        
    class << self

      def login(username, password)
        xml = self.new do |c|
          c.login(username, password)
        end
        return xml
      end

      def hello
      end
    end
              
private

    def tag!(name, *opts, &block)
      tag = @doc.create_element(name, *opts)
      insert(tag, &block)
    end

    def cltrid
      "#{EPP.configuration.cltrid}-#{Time.now.to_i}"
    end

  end
end
