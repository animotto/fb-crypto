#!/usr/bin/env ruby

# frozen_string_literal: true

##
# Permutation cipher
class Cipher
  BLOCK_SIZE = 10

  def initialize(input = $stdin, output = $stdout, block_size: BLOCK_SIZE)
    @input = input
    @output = output
    @block_size = block_size
  end

  def decode
    while (block = @input.read(@block_size))
      @output.write(permute(block))
    end
  end

  private

  def permute(block)
    return block if block.length < @block_size

    out = String.new
    out[0] = block[3]
    out[1] = block[4]
    out[2] = block[1]
    out[3] = block[0]
    out[4] = block[2]
    out[5] = block[8]
    out[6] = block[9]
    out[7] = block[6]
    out[8] = block[5]
    out[9] = block[7]

    out
  end
end

cipher = Cipher.new
cipher.decode
