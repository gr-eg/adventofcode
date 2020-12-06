groups = File.read("input.txt").split("\n\n")

counts = groups.map do |group|
  group
    .split("\n")
    .map { |x| x.split("") }
    .flatten!
    .uniq
    .count
    .to_i
end

puts counts.sum

counts = groups.map do |group|
  group
    .split("\n")
    .map { |x| x.split("") }
end

foo = counts.map do |x|
  x.reduce do |acc, i|
    acc = acc & i.flatten
  end.count
end
puts foo.sum
