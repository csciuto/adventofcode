#!/usr/bin/ruby

require "./advent_utils"
require 'digest'

data = AdventUtils.get_data("4.txt")

num_to_try = 0
continue = true

while continue do
  md5 = Digest::MD5.new
  md5.update data + num_to_try.to_s
  hash_output = md5.hexdigest
  
  if num_to_try % 100000 == 0
    puts num_to_try
  end
  
  if hash_output.start_with? "000000"
    puts "Answer is #{num_to_try}"
	continue = false
  else
    num_to_try += 1
  end
  
end