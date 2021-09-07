#!/usr/bin/env ruby

# frozen_string_literal: true

require 'base64'

##
# Stream cipher
class Cipher
  def initialize
    @gamma = String.new
  end

  def calc_gamma(text, data)
    raise 'Size of text and data is not equal' if text.bytesize != data.bytesize

    text.each_byte.with_index do |b, i|
      @gamma << (b ^ data[i].ord)
    end
  end

  def encode(text)
    if @gamma.bytesize < text.bytesize
      raise "Size of gamma (#{@gamma.bytesize}) is not enough to encode text (#{text.bytesize})"
    end

    out = String.new
    text.each_byte.with_index do |b, i|
      out << (b ^ @gamma[i].ord)
    end
    out
  end
end

print 'Random date: '
text = $stdin.readline.strip
print 'Encrypted form: '
data = [$stdin.readline.strip].pack('H*')

cipher = Cipher.new
begin
  cipher.calc_gamma(text, data)
rescue StandardError => e
  puts e
  exit
end

print 'Text: '
text = $stdin.readline.strip
begin
  data = cipher.encode(text)
rescue StandardError => e
  puts e
  exit
end

puts
puts Base64.strict_encode64(data)
