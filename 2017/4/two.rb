input = File.readlines('input.txt').map(&:split)

def unique_passwords(password)
  password.map { |x| x.chars.sort.join }.uniq
end

valid = input.count do |password|
  unique_passwords(password).length == password.length
end

p valid
