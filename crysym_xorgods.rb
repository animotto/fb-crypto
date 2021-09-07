#!/usr/bin/env ruby

# frozen_string_literal: true

##
# XOR cipher
class Cipher
  KEY_CHAR = '='

  attr_accessor :key

  def initialize(file, data)
    @file = file
    @data = data
    @key = String.new
  end

  def find_key
    loop do
      @key << (@file.read(1).ord ^ @data.read(1).ord)
      break if @key[-1] == KEY_CHAR
    end
  end

  def decode(output)
    @data.rewind
    i = 0
    while (byte = @data.read(1))
      data = @key[i % @key.bytesize].ord ^ byte.ord
      output.write(data.chr)
      i += 1
    end
  end
end

if ARGV.empty?
  puts "#{__FILE__} <file> <enc1> <enc2>"
  exit
end

file = File.open(ARGV[0])
data1 = File.open(ARGV[1])
data2 = File.open(ARGV[2])

cipher1 = Cipher.new(file, data1)
cipher1.find_key
cipher2 = Cipher.new(file, data2)
cipher2.key = cipher1.key
cipher2.decode($stdout)
