#!/usr/bin/env ruby
require 'byebug'

input = File.readlines('input.txt').map { |x| x.chomp.split(', ').map(&:to_i) }

arr = Array.new(0, [])
# byebug

edges = []
# alpha = ('a'..'z').to_a[0...input.count]
ymax = (input.max_by{ |x| x[0] }[0]) + 1
xmax = input.max_by{ |x| x[1] }[1]

(0..ymax).each do |y|
  (0..xmax).each do |x|
    arr[x] ||= []
    index = input.index([y, x])
    arr[x][y] = [index, 0] if index
    next if index

    input.each do |place|
      distance = (y - place[0]).abs + (x - place[1]).abs
      if arr[x][y] && arr[x][y][1].to_i == distance
        arr[x][y] = ['.', distance]
      else
        letter = input.index(place)
        # letter = alpha[input.index(place)]
        unless arr[x][y] && arr[x][y][1].to_i < distance
          arr[x][y] = [letter, distance]
          if x.zero? || y.zero? || x == xmax+1 || y == ymax
            edges << [letter]
          end
        end
      end
    end
  end
end

finite = (0...input.count).to_a - edges.uniq.flatten
part1 = arr.map { |x| x.map(&:first) }.flatten.keep_if { |x| finite.include? x }.group_by(&:itself).map { |k,v| [k, v.count] }.max_by { |x| x[1]}[1]
puts "Part 1: #{part1}"
# puts arr.map { |a| a.map { |i| i[0].to_s.rjust(7) }.join }
