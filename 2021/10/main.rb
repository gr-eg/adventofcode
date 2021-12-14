lines = File.readlines("input.txt").map { |x| x.chomp }

RGXP = /<>|\[\]|\(\)|\{\}/

opening_braces = ['[', '<', '{', '(']
closing_braces = [']', '>', '}', ')']
points = {
  ')' =>  3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

def match_braces(str, last_match = "")
  tmp = str.gsub(RGXP, "")
  return tmp if tmp == last_match
  last_match = tmp
  match_braces(last_match, last_match)
end

corrupt = lines.map do |line|
  remaining = match_braces(line).split("")
  !(remaining.all? { |x| opening_braces.include?(x) }) ? remaining : nil
end

illegals = corrupt.compact.map do |x|
  x.filter { |char| closing_braces.include?(char) }.first
end

totals = illegals.map do |x|
  points[x]
end

puts totals.sum
