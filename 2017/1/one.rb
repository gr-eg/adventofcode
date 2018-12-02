chars = File.read('input.txt').chomp.chars.map(&:to_i)

pairs = chars.each_cons(2).to_a
pairs << [chars[0], chars[-1]]
pairs = pairs.select { |x, y| x == y }
pairs = pairs.map(&:uniq).flatten.inject(:+) || 0

puts pairs
