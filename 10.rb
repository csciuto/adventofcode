#!/usr/bin/ruby

require "./advent_utils"

data = AdventUtils.get_data("10.txt").chomp

#Returns the length
def solve_problem(data, times)
  (1..times).each do |current_count|
	puts "Iteration: #{current_count} Timestamp: #{Time.now.to_i.to_s}"
    temp_string = ""
    data.scan(/((.)\2*)/) do |match|	  
      temp_string = temp_string + $1.length.to_s + $1[0].to_s	
    end
    data = temp_string
	puts "Iteration: #{current_count} Loop timestamp: #{Time.now.to_i.to_s}."
  end
  data.length
end

length = solve_problem(data, 50)

puts "Final length: #{length}"