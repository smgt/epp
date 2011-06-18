require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require "nokogiri"
require "markup_validity"

epp_schema = File.read(File.dirname(__FILE__) + "/schemas/all.xsd")

describe "EPP::Builder" do
  describe "login" do
    it "should output valid xml" do
      xml =  EPP::Builder.login("username", "password")
      puts xml
      xml.should be_valid_with_schema(epp_schema)
    end
  end
end

describe "EPP::Builder" do
  describe "domain check" do
    it "should output valid xml" do
      fail
    end
  end
end

describe "EPP::Builder" do
  describe "domain find" do
    it "should output valid xml" do
      fail
    end
  end
end

describe "EPP::Builder" do
  describe "#domain_update" do
    it "should output valid xml" do
      fail
    end
  end
end
