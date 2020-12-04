require "benchmark"
require "byebug"

puts Benchmark.measure {
  rows = File.readlines("input.txt").map { |x| x.chomp.split("") }

  routes = [[1,1], [3,1], [5,1], [7,1], [1,2]]

  trees = 1

  routes.each do |r| 
    posX = 0
    posY = 0
    t = 0

    rows.size.times do |row|
      break if posX > rows.count
      while rows[posX][posY].nil?
        rows[posX] += rows[posX]
      end
      t += 1 if rows[posX][posY] == "#"
      posX += r[1]
      posY += r[0]
    end
    trees = trees * t
  end

  puts trees

}.real * 1000
