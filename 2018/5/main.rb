#!/usr/bin/env ruby

def react(input)
  new_input = input.sub(/((.)(?-i)(?!\2)(?i)\2)/, '')
  return new_input if input == new_input
  react(new_input)
end

input = File.read('input.txt').chomp
puts "Part 1: #{react(input).chars.count}"

polymers = []

input.chars.map(&:downcase).uniq.map do |char|
  polymers << react(input.gsub(/#{char}/i, '')).chars.count
end

puts "Part 2: #{polymers.min}"
