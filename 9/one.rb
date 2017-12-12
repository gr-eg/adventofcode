require "byebug"
input = File.read('input.txt').chars

nesting = 0
i = 0
score = 0
inside_garbage = false

while i < input.length do
  x = input[i]
  
     if  x == '!' then i += 1
  elsif  x == '<' then inside_garbage = true
  elsif  x == '>' then inside_garbage = false
  elsif inside_garbage then nil # noop
  elsif  x == '{' then score += (nesting += 1)
  elsif  x == '}' then nesting -= 1 end
  i += 1
end


p score
