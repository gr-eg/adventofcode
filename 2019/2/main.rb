require 'pry-byebug'

lines = File.read('input.txt').split(",").map(&:to_i)

index = 0
lines[1] = 12
lines[2] = 2

while lines[index] != 99
  p1 = lines[index + 1]
  p2 = lines[index + 2]
  out = lines[index + 3]
  case lines[index]
  when 1
    res = lines[p1] + lines[p2]
  when 2
    res = lines[p1] * lines[p2]
  end
  lines[out] = res
  index += 4
end

puts lines[0]
