#!/usr/bin/env ruby

# frozen_string_literal: true

require 'base32'

data = $stdin.read
data = Base32.decode(data)
data.gsub!('\x5c\x78', '')
data.gsub!('\x', '')
data = [data].pack('H*')
data = [data].pack('H*')
data.gsub!('\x', '')
data = [data].pack('H*')
puts data
