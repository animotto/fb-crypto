#!/usr/bin/env ruby

# frozen_string_literal: true

require 'net/http'

##
# HTTP client
class Client
  HOST = '2019-12-01-xflip.ctf.su'
  PORT = 443

  attr_accessor :cookie

  def initialize
    @client = Net::HTTP.new(HOST, PORT)
    @client.use_ssl = (PORT == 443)
    @cookie = String.new
  end

  def name(name)
    response = @client.get(
      "/?#{URI.encode_www_form(
        'set_name' => '',
        'name' => name
      )}"
    )

    @cookie = response['Set-Cookie'].split(';')[0].split('=')[1]
    @cookie = URI.decode_www_form_component(@cookie)
  end

  def greet
    request = Net::HTTP::Get.new("/?#{URI.encode_www_form('greet' => '')}")
    request['Cookie'] = "user=#{URI.encode_www_form_component(@cookie)};"
    @client.request(request).body
  end
end

LOGIN = 'admin'
FILL_CHAR = 'x'
OFFSET = 10

client = Client.new
data = String.new
LOGIN.length.times do |i|
  login = FILL_CHAR * LOGIN.length
  login[i] = LOGIN[i]
  client.name(login)
  data << client.cookie[OFFSET + i]
end

client.cookie[OFFSET..(OFFSET + LOGIN.length - 1)] = data
puts client.greet
