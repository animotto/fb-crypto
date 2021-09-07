#!/usr/bin/env ruby

# frozen_string_literal: true

##
# Stream cipher
class Cipher
  def initialize
    @gamma = String.new
  end

  def calc_gamma(text, cipher)
    raise 'Size of text and cipher is not equal' if text.bytesize != cipher.bytesize

    text.each_byte.with_index do |b, i|
      @gamma << (b ^ cipher[i].ord)
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

print 'Text1: '
text1 = $stdin.readline.strip
print 'Cipher1: '
cipher1 = $stdin.readline.strip
print 'Cipher2: '
cipher2 = $stdin.readline.strip

cipher = Cipher.new
begin
  cipher.calc_gamma(text1, [cipher1].pack('H*'))
  text2 = cipher.encode([cipher2].pack('H*'))
rescue StandardError => e
  puts e
  exit
end

puts text2
