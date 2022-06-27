#!/usr/bin/ruby

require 'uri'
require 'httparty'
require 'nokogiri'

names = File.open('manifest').readlines

names.each do |name|
  print_value = ""
  name.chomp!
  first_name = name.split(' ').first
  last_name = name.split(' ').last

  url = URI("https://www.princeton.edu/search/people-advanced?f=#{first_name}&ff=c&l=#{last_name}&lf=c")
  response = HTTParty.get(url)
  document = Nokogiri::HTML.parse(response.body) if response.code == 200

  print_value = "N/A" if response.body.include?("No results.")

  document.css(".columns").each do |item|
    if item.text.include?("NetID") && item["class"] == "columns small-12 medium-6 large-3 js-hideshow"
      item_index = item.text.include?("Fax") ? 8 : 3
      netid = item.children[item_index].children.first.text
      print_value = "#{netid}"
    end
  end

  puts print_value

end
