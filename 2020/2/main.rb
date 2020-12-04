
require "byebug"
lines = File.readlines("input.txt")

lines = lines.map { |x| x.split(" ") }

a = lines.select do |line|
  min, max = line[0].split("-")
  occurences = line[2].count(line[1])
  occurences >= min.to_i && occurences <= max.to_i
end.count

b = lines.select do |line|
  first, last = line[0].split("-")
  char = line[1][0]
  (line[2][first.to_i - 1] == char) ^ (line[2][last.to_i - 1] == char)
end.count

puts a
puts b
