require 'byebug'
require 'pp'

input = [147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70].join(',')
list = (0..255).to_a

input = input.chars.map { |x| x.ord }
input = input + [17, 31, 73, 47, 23]


current_position = 0
skip = 0 

64.times do
  input.each do |length|
    to_r = (0...length).map do |x|
      list[(current_position + x) % list.length]
    end.reverse

    (current_position...(current_position + to_r.length)).each_with_index do |x, i|
      list[x % list.length] = to_r[i]
    end

    current_position += length + skip
    skip += 1
  end
end

pp list.each_slice(16).map { |x| x.inject(:^) }.map {|x| x.to_s(16).rjust(2, '0') }.join

