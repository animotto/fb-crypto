#!/usr/bin/env ruby

# frozen_string_literal: true

require 'punycode'

print 'Text: '
text = $stdin.readline.strip
puts Punycode.decode(text)
