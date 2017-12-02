require 'byebug'
input = File.read('input.txt')

arr = input.split("\n").map(&:split)
arr = arr.map { |x| x.map(&:to_i) }
arr = arr.map { |x| x.sort_by{ |sort| -sort }}

divisibles = []

arr.map do |row|
  row.map.with_index do |head, index|
    h, t = head, row[index+1..-1]
    divisible = t.find { |x| h % x == 0 }
    divisibles << h / divisible if divisible
  end
end

p divisibles.sum