#!/usr/bin/ruby

require "set"
require "./advent_utils"

data = AdventUtils.get_data("7.txt")

$signals = Hash.new
$instructions = Set.new

def resolve_token(token)
  if token.scan(/\D/).count > 0
    $signals[token]
  else
    token.to_i
  end
end

def binary_token(tokens)
  input1 = resolve_token(tokens[0])
  input2 = resolve_token(tokens[2])
  return if input1.nil? || input2.nil?
  output = tokens[4]   
  $signals[output] = yield input1, input2
  $instructions.delete tokens
end

data.each_line do |input_string|
  tokens = input_string.split " "
  $instructions << tokens
end
 
 while $instructions.count > 0 do
 
   $instructions.each do |tokens|
   
    if tokens[0] == "NOT"
     input = resolve_token(tokens[1])
     next if input.nil?
     output = tokens[3]   
     $signals[output] = ~input
	 $instructions.delete tokens
    elsif tokens[1] == "AND"
     binary_token(tokens) {|input1, input2| input1 & input2}	 
    elsif tokens[1] == "OR"
     binary_token(tokens) {|input1, input2| input1 | input2}
    elsif tokens[1] == "LSHIFT"
     binary_token(tokens) {|input1, input2| input1 << input2.to_i}
    elsif tokens[1] == "RSHIFT"
     binary_token(tokens) {|input1, input2| input1 >> input2.to_i}
    else
	  #Input starts here...
      input = resolve_token(tokens[0])
	  next if input.nil?
      output = tokens[2]     
      $signals[output] = input.to_i	
	  $instructions.delete tokens
    end
  end
 end
 
keys = $signals.keys.sort
keys.each do |x|
  value = $signals[x]
  puts "Value of wire #{x} = #{value}"
end