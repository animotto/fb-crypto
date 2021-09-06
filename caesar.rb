#!/usr/bin/env ruby

# frozen_string_literal: true

##
# Caesar cipher
class Caesar
  DEFAULT_DICTIONARY = ('A'..'Z').to_a

  def initialize(shift = 3, dictionary: DEFAULT_DICTIONARY)
    @shift = shift
    @dictionary = dictionary
  end

  def transform(text, dir = 1)
    out = String.new
    text.upcase.each_char do |char|
      i = @dictionary.index(char)
      if i.nil?
        out << char
        next
      end
      out << @dictionary[(i + @shift * dir) % @dictionary.length]
    end
    out
  end

  def encode(text)
    transform(text, 1)
  end

  def decode(text)
    transform(text, -1)
  end
end

DICTIONARY = %w[А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ъ Ы Ь Э Ю Я].freeze

print 'Text: '
text = $stdin.readline
puts

DICTIONARY.length.times do |i|
  caesar = Caesar.new(i, dictionary: DICTIONARY)
  puts caesar.decode(text)
end
