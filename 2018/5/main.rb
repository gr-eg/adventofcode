#!/usr/bin/env ruby

def react(input)
  new_input = input.sub(/((.)(?-i)(?!\2)(?i)\2)/, '')
  return new_input if input == new_input
  react(new_input)
end

input = File.read('input.txt')
puts react(input).chomp.chars.count
