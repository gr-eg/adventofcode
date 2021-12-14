lines = File.readlines("input.txt").map { |x| x.chomp.split("").map(&:to_i) }

low_points = lines.flat_map.with_index do |line, row|
  line.map.with_index do |x, col|
    up = row > 0 ? lines[row - 1][col] : 9
    down = row < (lines.count - 1) ? lines[row + 1][col] : 9
    left = col > 0 ? lines[row][col - 1] : 9
    right = lines[row][col + 1] || 9
    x < [up, down, left, right].min ? [row, col] : nil
  end.compact
end

@areas = lines.map { |x| x.map { |y| y < 9 ? -1 : y} }

def find_basin(row, col, fill)
   return if(@areas[row][col] == 9)
   return if(@areas[row][col] == fill)

   @areas[row][col] = fill

   find_basin(row + 1, col, fill) if row < (@areas.count - 1)
   find_basin(row - 1, col, fill) if row > 0
   find_basin(row, col + 1, fill) if col < (@areas[0].count - 1)
   find_basin(row, col - 1, fill) if col > 0

   return
end

point = 10
low_points.each do |x|
  find_basin(x[0], x[1], point)
  point += 1
end

part1 = low_points.map { |x| lines[x[0]][x[1]] + 1 }.sum
part2 = @areas.flatten
              .filter { |x| x > 9 }
              .group_by { |i| i }
              .map{|k,v| [k, v.count][1] }
              .max(3)
              .inject(:*)
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
