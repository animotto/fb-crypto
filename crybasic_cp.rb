#!/usr/bin/env ruby

# frozen_string_literal: true

print 'Text: '
text = $stdin.readline.strip
puts text.encode('cp866')
