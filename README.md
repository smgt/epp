EPPClient -- extensible provisioning protocol client
==============================================

## DESCRIPTION

With this gem you can access a EPP server to create, delete, update contacts,
domains and hosts. 

## INSTALLATION

You can install EPP via RubyGems:

    $ [sudo] gem install epp

The EPP gem depends on a couple different gems:

* Nokogiri  

## GET STARTED

### Configure

To initialize the EPP gem:

  # Require RubyGems if needed
  require "rubygems"

  # Require the EPP gem
  require "epp"

  EPP.configure do |config|
    config.host "eppserver.hostname.local"
    config.port "700" # Default: 700
    condif.username "janedoe"
    config.password "secret"
    config.ssl true # Default: true
    config.certificate "/tmp/cert.pem"
  end

### Contacts

Check if contacts are available at the server:

    # Check if one contact is available
    EPP::Contact.available?("janedoe-001")
    # => true

    # Lookup multiple contacts
    EPP::Contact.available?(%w(janedoe-001 jamesdoe-001 rambo-003))
    # => {"janedoe-001" => {:available => true, :reason => ""}, "jamesdoe-001" 
    => {:available => true, :reason => ""}, "rambo-003" => {:available => 
    false, :reason => "In use"}}

Retrieve information associated with a contact:

    # Trying to find a non-existing contact
    EPP::Contact.find("janedoe-001")
    # => false

    # Lookup a existing contact
    EPP::Contact.find("rambo-003")
    # => #<EPP::Contact name: "Rambo", organisation: "USA", city: "Jungle",
    country: "US", email: "killkillkill@hotmale.com", client_id: "rambo-003">

    # On some EPP implementations requires a password to access contacts
    EPP::Contact.find("rambo-004", :password => "red5unset")
    # => #<EPP::Contact name: "Rambo", organisation: "USA", city: "Jungle",
    country: "US", email: "killkillkill@hotmale.com", client_id: "rambo-004">

Create a new contact:

    contact = EPP::Contact.new

    # Supply some information to the object
    contact.name = "Jane Doe"
    contact.organisation = "Acme Corp" # Optional
    contact.street = "Street 1337" # Optional
    contact.city = "Metropolis"
    contact.region = "Wonderland" # Optional
    contact.zip = "123456" # Optional
    contact.country = "NA"
    contact.voice = "+12.34567890" # Optional
    contact.fax = "+12.34567890" # Optional
    contact.email = "jane@wonderland.local"
    contact.client_id = "janedoe-001"
    contact.password = "secret"
    contact.disclose_email = true # Optional
    contact.disclose_voice = false # Optional
    
    # Now create the contact at the EPP server
    contact.save
    # => #<EPP::Respone message: "Command completed successfully" response_code:
    1000>

    # Failing to create a contact
    contact.save
    # => #<EPP::Response message: "" response_code:>

Delete a contact

    # You can either find and delete a EPP::Contact class
    EPP::Contact.delete("janedoe-001")
    # => #<EPP::Response message: "", response_code: 1001>

    # Or you can delete the EPP::Contact object
    contact = EPP::Contact.find("rambo-003")
    # => #<EPP::Contact name: "Rambo", organisation: "USA", city: "Jungle",
    country: "US", email: "killkillkill@hotmale.com", client_id: "rambo-003">
    contact.delete
    # => #<EPP::Response message: "", response_code:>

Transfer a contact

    # Transfer a contact from another operator

    # Query the status of a ongoing transfer

Update a contact

    # Find and update a contact
    contact = EPP::Contact.find("janedoe-001")
    # => #<EPP::Contact name: "Jane Doe", organisation: "Acme Corp", street:
    "Street 1337", city: "Metropolis", region: "Wonderland", zip: 123456, 
    country: "NA", voice: "+12.34567890", fax: "+12.34567890", email: 
    "jane@wonderland.local", client_id: "janedoe-001", password: "secret", 
    disclose_email: true, disclose_voice: false, message: "Command completed
    successfully" response_code: 2011>

    # Update the organisation
    contact.organisation = "Acme Corp United"
    # => "Acme Corp United"

    # Save the changes
    contact.save
