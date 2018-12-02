input = File.readlines('input.txt').map(&:split)

valid = input.count { |x| x.length == x.uniq.length }

p valid
