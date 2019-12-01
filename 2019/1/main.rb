lines = File.readlines('input.txt').map(&:to_i)

def calc_required(amount)
  (amount / 3).floor - 2
end

def calc_fuel(amount)
  required_next = calc_required(amount)
  required_next > 0 ? (required_next + calc_fuel(required_next)) : 0
end

puts "Part 1: #{lines.map { |x| calc_required(x) }.sum}"
puts "Part 2: #{lines.map { |x| calc_fuel(x) }.sum}"
