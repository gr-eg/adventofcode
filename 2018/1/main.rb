#!/usr/bin/env ruby
require 'byebug'

lines = File.readlines('input.txt')
freq = 0

lines.map { |x| freq += x.to_i }

puts "Part 1: #{freq}"

frequencies = {}
repeated = false
freq = 0

until repeated
  lines.each do |x|
    freq += x.to_i

    if frequencies.key?(freq)
      repeated = true
      break
    end

    frequencies[freq] = 0
  end
end

puts "Part 2: #{freq}"
