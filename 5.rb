#!/usr/bin/ruby

require "set"
require "./advent_utils"

def double_letter(str)
  last_char=str[0]
  str[1..str.length].each_char do |char|
    return true if char == last_char	  
	last_char = char
  end
  false  
end

def find_pair(str)
  
  pairs = Set.new
  last_char=str[0]
  last_pair = ""
  str[1..str.length].each_char do |char|
    pair = last_char + char
	
	next if pair == last_pair
	
    return true if pairs.include? pair
	
	pairs.add pair
	
	last_char = char
	last_pair = pair
  end
  
  return false
end

def find_repeat(str)
  (2..str.length).each do |i|
   return true if str[i] == str[i-2]
  end
  
  return false
end

data = AdventUtils.get_data("5.txt")

nice_count = 0

data.each_line do |input_string|

  input_string.chomp!
  
  # next if input_string.include? "ab" or input_string.include? "cd" or \
     # input_string.include? "pq" or input_string.include? "xy"
  # next unless input_string.count("aeiou") >= 3
  # next unless double_letter(input_string)
  
  next unless find_pair(input_string)
  next unless find_repeat(input_string)
  
  nice_count += 1
end

puts "Nice Strings: #{nice_count}"