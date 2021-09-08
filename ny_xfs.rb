#!/usr/bin/env ruby

# frozen_string_literal: true

require 'net/http'

##
# HTTP client
class Client
  HOST = 'crypto-kids20.forkbomb.ru'
  PORT = 443
  PATH = '/files/ny/xfs/task'

  def initialize
    @client = Net::HTTP.new(HOST, PORT)
    @client.use_ssl = (PORT == 443)
  end

  def get(file)
    response = @client.get("#{PATH}/#{file}.html")
    return false unless response.instance_of?(Net::HTTPOK)

    match = %r{<iframe src="(\w+).html" frameborder="0"></iframe>}.match(response.body)
    next_file = get(match[1])
    return file unless next_file

    next_file
  end
end

client = Client.new
puts client.get('index')
