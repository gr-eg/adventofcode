lines = File.readlines("inputs/part1.txt").map(&:to_i)

puts lines.each_cons(2).count { |a,b| b > a }
puts lines.each_cons(3).map { |x| x.sum }.each_cons(2).count { |a,b| b > a }



