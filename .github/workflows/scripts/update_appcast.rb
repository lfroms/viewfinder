#!/usr/bin/env ruby
# frozen_string_literal: true

raise 'Could not read from the RELEASE environment variable. Was it set?' if ENV['RELEASE'].nil?

require 'json'
require 'date'
require 'nokogiri'
require 'redcarpet'

release = JSON.parse(ENV['RELEASE'], symbolize_names: true)

asset_filename = ENV['asset_filename']
asset_url = ENV['asset_url']
signature_data = ENV['signature_data']

APPCAST_FILENAME = 'appcast.xml'

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)

parsed_signature_data = Nokogiri::XML::DocumentFragment
  .parse("<dummy #{signature_data} />")
  .children
  .first
  .to_h

unless File.file?(APPCAST_FILENAME)
  builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
    xml.rss('xmlns:sparkle' => 'http://www.andymatuschak.org/xml-namespace/sparkle', 'version' => '2.0') {
      xml.channel {
        xml.title 'Viewfinder'
      }
    }
  end

  File.open(APPCAST_FILENAME, 'w') do |file|
    file.write(builder.to_xml)
  end
end

appcast = Nokogiri::XML.parse(File.read(APPCAST_FILENAME)) { |x| x.noblanks }

published_date = DateTime.parse(release[:published_at]).rfc2822

Nokogiri::XML::Builder.with(appcast.at('channel')) do |xml|
  xml.item {
    xml.title release[:name]
    xml.link 'https://github.com/lfroms/viewfinder'
    xml['sparkle'].version release[:tag_name]
    xml.description {
      xml.cdata markdown.render(release[:body])
    }
    xml.pubDate published_date
    xml.enclosure(
      url: asset_url,
      **parsed_signature_data,
      type: 'application/octet-stream'
    )
  }
end

# Move newly appended node to the top.
if appcast.xpath('//item').count > 1
  appcast.at_xpath('//item[1]').add_previous_sibling(appcast.at_xpath('//item[last()]'))
end

File.open(APPCAST_FILENAME, 'w') do |file|
  file.write(builder.to_xml)
end