def matches?(input)
  digits = input.digits.reverse
  digits.each_cons(2).all? { |x,y| y >= x } &&
  digits.each_cons(2).any? { |x,y| y == x } &&
  digits.group_by { |x| x }.map{|k,v| [k, v.count] }.any? { |_,x| x == 2 }
end

puts (248345...746315).to_a.select { |x| matches?(x) }.count
