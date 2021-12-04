lines = File.readlines("input.txt").map(&:chomp)

def calculate_rating(lines, position, operation)
  return lines[0] if lines.one?
  common = most_common_bit(lines, position) 
  filtered = lines.filter { |x| x[position].send(operation, common) }
  calculate_rating(filtered, position + 1, operation)
end

def most_common_bit(lines, position)
  ones = lines.count { |x| x[position] == "1" } 
  ones >= (lines.count - ones) ? "1" : "0"
end

def calculate_oxygen(lines, position)
  calculate_rating(lines, position, :==)
end

def calculate_co2(lines, position)
  calculate_rating(lines, position, :!=)
end

puts calculate_oxygen(lines, 0).to_i(2) * calculate_co2(lines, 0).to_i(2)

