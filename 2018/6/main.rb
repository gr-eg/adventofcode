#!/usr/bin/env ruby
require 'byebug'

input = File.readlines('input.txt').map { |x| x.chomp.split(', ').map(&:to_i) }

arr = Array.new(0, [])

edges = []
distances = Hash.new(0)
ymax = (input.max_by { |x| x[0] }[0]) + 1
xmax = input.max_by { |x| x[1] }[1]

(0..ymax).each do |y|
  (0..xmax).each do |x|
    arr[x] ||= []

    input.each do |place|
      distance = (y - place[0]).abs + (x - place[1]).abs
      name = input.index(place)
      distances["#{x},#{y}"] += distance

      if arr[x][y] && arr[x][y][1].to_i == distance
          arr[x][y] = ['.', distance]
      else
        unless arr[x][y] && arr[x][y][1].to_i < distance
          arr[x][y] = [name, distance]
          if x.zero? || y.zero? || x == xmax + 1 || y == ymax
            edges << [name]
          end
        end
      end
    end
  end
end

finite = (0...input.count).to_a - edges.uniq.flatten
part1 = arr.map { |x| x.map(&:first) }.flatten.keep_if { |x| finite.include? x }.group_by(&:itself).map { |k,v| [k, v.count] }.max_by { |x| x[1]}[1]
puts "Part 1: #{part1}"

part2 = distances.values.select { |x| x < 10_000 }.count
puts "Part 2: #{part2}"
