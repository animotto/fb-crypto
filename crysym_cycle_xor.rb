#!/usr/bin/env ruby

# frozen_string_literal: true

##
# Cycle XOR cipher
class Cipher
  def initialize(key, input: $stdin, output: $stdout)
    @key = key
    @input = input
    @output = output
  end

  def encode
    i = 0
    while (byte = @input.read(1))
      @output.write((byte.ord ^ @key[i % @key.bytesize].ord).chr)
      i += 1
    end
  end
end

if ARGV.empty?
  puts "#{__FILE__} <key>"
  exit
end

cipher = Cipher.new(ARGV[0])
cipher.encode
