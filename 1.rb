#!/usr/bin/ruby

require "./advent_utils"

count = 0
position = 1
found = false

data = AdventUtils.get_data("1.txt")

# Just add one floor when we see ( and take one away when we see ).
# After we've hit a cellar (negative number) once, report that as well.
data.each_char do |char|
  if char == "("
    count += 1
  else
    count -= 1
  end
  
  if count < 0 && found == false
    puts "I'm in the basement on position #{position}"
	found = true
  end
  position += 1
  
end

puts "Final Count: #{count}"