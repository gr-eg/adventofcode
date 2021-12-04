lines = File.readlines("input.txt").map { |x| x.split(" ") }

horizontal = 0
depth = 0
aim = 0

lines.each do |movement, amount|
  amount = amount.to_i
  if movement == "forward"
    horizontal += amount
    depth += aim * amount
  end
  aim += amount if movement == "down"
  aim -= amount if movement == "up"
end

puts horizontal * depth


