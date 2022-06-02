#!/usr/bin/ruby

require 'net/ldap'

require 'pry'

def find_by_display(display_name, ldap_connection: default_connection)
  first_name, last_name = display_name.split(' ')
  filter = Net::LDAP::Filter.eq('sn', last_name) & Net::LDAP::Filter.eq('givenname', first_name) & Net::LDAP::Filter.eq('edupersonprimaryaffiliation','staff')
  result = ldap_connection.search(filter: filter)
  if result.empty?
    filter = Net::LDAP::Filter.eq('sn', last_name) & Net::LDAP::Filter.eq('givenname', first_name) & Net::LDAP::Filter.eq('edupersonprimaryaffiliation','faculty')
    result = ldap_connection.search(filter: filter)
    if result.empty?
      print "N/A\n"
    else
      print "#{result.first[:uid].pop}\n"
    end
  else
    print "#{result.first[:uid].pop}\n"
  end
end

def default_connection
  @default_connection ||=
  begin
    Net::LDAP.new(
      host: 'ldap.princeton.edu',
      base: 'o=Princeton University,c=US',
      port: 636,
      encryption: {
        method: :simple_tls,
        tls_options: OpenSSL::SSL::SSLContext::DEFAULT_PARAMS
      }
    )
  end
end

names = File.open('manifest').readlines

names.each do |display_name|
  print_value = ""
  display_name.chomp!
  find_by_display(display_name)
end
