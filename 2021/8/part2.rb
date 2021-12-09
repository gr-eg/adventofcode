lines = File.readlines("input.txt").map { |x| x.chomp.split(" | ") }

decoded_values = lines.map do |inputs, outputs|
  inputs = inputs.split(" ").map { |x| x.split("") }
  mappings = {}
  #first pass for fixed lengths
  inputs.each do |x|
    case x.length
    when 2
      mappings[1] = x
    when 3
      mappings[7] = x
    when 4
      mappings[4] = x
    when 7
      mappings[8] = x
    endxw
  end

  inputs.each do |x|
    next if [2,3,4,7].include?(x.length)
    case x.length
    when 5
      if (x - mappings[7]).count == 2
        mappings[3] = x
      elsif (mappings[4] - x).length == 2
        mappings[2] = x
      elsif (mappings[4] - x).length == 1
        mappings[5] = x
      end
    when 6
      if (mappings[1] - x).length == 1
        mappings[6] = x
      elsif (mappings[4] - x).length == 1
        mappings[0] = x
      elsif (mappings[4] - x) == []
        mappings[9] = x
      end
    end
  end

  mappings = mappings.invert.transform_keys(&:sort)

  decoded = outputs.split(" ").map do |output_digit|
    mappings[output_digit.split("").sort]
  end
  decoded.join.to_i
end

puts decoded_values.sum
