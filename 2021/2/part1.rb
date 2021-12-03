lines = File.readlines("input.txt").map { |x| x.split(" ") }

horizontal = 0
depth = 0

lines.each do |movement, amount|
  amount = amount.to_i
  horizontal += amount if movement == "forward"
  depth += amount if movement == "down"
  depth -= amount if movement == "up"
end

puts horizontal * depth


