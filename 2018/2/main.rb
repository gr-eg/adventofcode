#!/usr/bin/env ruby
require 'byebug'

lines = File.readlines('input.txt').map! { |x| x.chomp.chars }
twos = 0
threes = 0

lines.each do |line|
  counts = Hash[line.uniq.map { |i| [line.count(i), i] }]
  twos += 1 if counts.key?(2)
  threes += 1 if counts.key?(3)
end

puts "Part 1#{twos} * #{threes} = #{twos * threes}"

winner = []

lines.repeated_combination(2).each do |first, second|
  candidate = []
  next if first == second
  first.zip(second).map { |x| candidate << x[0] if x[0] == x[1] }
  winner = candidate if candidate.length > winner.length
end

puts "Part 2: '#{winner.join}'"
