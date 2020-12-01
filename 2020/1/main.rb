lines = File.readlines("input.txt").map(&:to_i)

lines.combination(2) do |x|
  puts x[0] * x[1] if x.sum == 2020
end

lines.combination(3) do |x|
  puts (x[0] * x[1] * x[2]) if x.sum == 2020
end
