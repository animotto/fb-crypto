#!/usr/bin/env ruby

# frozen_string_literal: true

##
# Permutation cipher
class Permute
  BLOCK_SIZE = 4
  PAD_CHAR = ' '

  def transform(text)
    out = text.dup
    out << PAD_CHAR * (BLOCK_SIZE - out.length) if out.length < BLOCK_SIZE
    out << PAD_CHAR * (out.length % BLOCK_SIZE)
    (out.length / BLOCK_SIZE).times do |i|
      s = i * BLOCK_SIZE
      (BLOCK_SIZE / 2).times do |j|
        out[s + j * 2], out[s + j * 2 + 1] = out[s + j * 2 + 1], out[s + j * 2]
      end
    end
    out
  end
end

print 'Text: '
text = $stdin.readline.strip
puts

cipher = Permute.new
puts cipher.transform(text)
