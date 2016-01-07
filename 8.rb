#!/usr/bin/ruby

require "./advent_utils"

data = AdventUtils.get_data("8.txt")

code_count=0
memory_count=0

# data.each_line do |input_string|
  # input_string.chomp!
  # code_count += input_string.length
  # input_string = input_string[1..input_string.length-2]

  # output_string = ""
  
  # idx = 0
  # while idx < input_string.length
    # if input_string[idx]=="\\"
	  # idx += 1
	  # if input_string[idx]=="\\" || input_string[idx]=="\""
		# output_string += input_string[idx]
	  # elsif input_string[idx]=="x"
        # hex=input_string[idx+1..idx+2]
		# output_string += hex.to_i(16).chr
		# idx += 2
	  # end
	# else
	  # output_string += input_string[idx]	
	# end
	# idx += 1
  # end
  
  # puts output_string
  # memory_count += output_string.length  
# end

data.each_line do |input_string|
  input_string.chomp!
  code_count += input_string.length
  
  output_string = "\""
  idx = 0
  while idx < input_string.length
    if input_string[idx] == "\""
	  output_string += "\\\""
	elsif input_string[idx] == "\\"
	  output_string += "\\\\"
	else
	  output_string += input_string[idx]
	end
	idx += 1
  end
  output_string += "\""
  puts output_string
  memory_count += output_string.length  
end

puts "Code count: #{code_count}"
puts "Memory count: #{memory_count}"
puts "Difference: #{code_count - memory_count}"