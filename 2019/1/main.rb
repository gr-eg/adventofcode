lines = File.readlines('input.txt')

puts lines.map { |x| (x.to_i / 3).floor - 2 }.sum


