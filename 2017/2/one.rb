input = File.read('input.txt')

input = input.split("\n").map(&:split)
input = input.map {|x| x.map(&:to_i)}

p input.map(&:minmax).map{ |x,y| (x-y).abs }.sum