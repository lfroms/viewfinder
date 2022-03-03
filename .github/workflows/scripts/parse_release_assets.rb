#!/usr/bin/env ruby
# frozen_string_literal: true

raise 'Could not read from the RELEASE environment variable. Was it set?' if ENV['RELEASE'].nil?

require 'json'

release = JSON.parse(ENV['RELEASE'], symbolize_names: true)
github_env_file_path = ENV['GITHUB_ENV']

compiled_asset = release[:assets].find do |asset|
  asset[:name].end_with?('.dmg')
end

def key_value(key, value)
  "#{key}=#{value}"
end

File.open(github_env_file_path, 'a') do |file|
  file.puts(key_value('asset_filename', compiled_asset[:name]))
  file.puts(key_value('asset_url', compiled_asset[:browser_download_url]))
end
