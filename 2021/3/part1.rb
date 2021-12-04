lines = File.readlines("input.txt")


gamma = ""
epsilon = ""
(lines[0].length - 1).times.with_index do |_, i|
  ones = lines.count { |x| x[i].to_i == 1 }
  if ones > (lines.count / 2) 
    gamma += "1"
    epsilon += "0"
  else
    gamma += "0"
    epsilon += "1"
  end 
end

puts gamma.to_i(2) * epsilon.to_i(2)
