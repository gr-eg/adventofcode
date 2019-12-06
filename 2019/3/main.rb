circuits = File.readlines("input.txt").map { |x| x.split(",").map(&:chomp) }

points = []

circuits.each do |circuit|
  x = []
  pointer = [0, 0]
  circuit.each do |wire|
    case wire[0]
    when "U"
      wire[1..-1].to_i.times { |i| x << [pointer[0], pointer[1] += 1] }
    when "R"
      wire[1..-1].to_i.times { |i| x << [pointer[0] += 1, pointer[1]] }
    when "D"
      wire[1..-1].to_i.times { |i| x << [pointer[0], pointer[1] -= 1] }
    when "L"
      wire[1..-1].to_i.times { |i| x << [pointer[0] -= 1, pointer[1]] }
    end
  end
  points << x
end

intersections = (points[0] & points[1]).map { |x| [x[0].abs, x[1].abs] }

puts "Part 1: #{intersections.map(&:sum).min}"
