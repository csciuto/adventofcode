#!/usr/bin/ruby

require "./advent_utils"

class Lights

  def initialize
    @lights = Array.new(1000) { Array.new(1000,0) }
  end

  # Takes in a pair of coordinates
  def toggle(ul,lr)
    update_lights(ul,lr) do |i,j|
      if @lights[i][j] == 0
    	@lights[i][j] = 1		  
	  else
	    @lights[i][j] = 0
	  end
    end
  end
  
  # Takes in a pair of coordinates
  def toggle_up(ul,lr)
    update_lights(ul,lr) do |i,j|
	  @lights[i][j] += 2
    end
  end

  # Takes in a pair of coordinates and the state to change to
  def set_state(ul,lr,state)
    update_lights(ul,lr) do |i,j|
      @lights[i][j] = state
    end
  end

  # Takes in a pair of coordinates and the amount to change by.
  # Negative numbers go down
  def set_state_by(ul,lr,state)
    update_lights(ul,lr) do |i,j|
      @lights[i][j] += state
	  if @lights[i][j] < 0
	    @lights[i][j] = 0
	  end
    end
  end
  
  def count_lit_lights
    lit_count = 0
    @lights.each do |i|
      i.each do |j|
	    if j == 1
		  lit_count += 1
		end
	  end
	end
	
	return lit_count
  end
  
   def count_total_brightness
    brightness = 0
    @lights.each do |i|
      i.each do |j|	    
		brightness += j
	  end
	end
	
	return brightness
  end
  
private  
  def update_lights(ul,lr)
    start_x = ul[0]
    end_x = lr[0]
  
    start_y = ul[1]
    end_y = lr[1]
  
    (start_x..end_x).each do |i|
      (start_y..end_y).each do |j|
        yield i,j
	  end
    end
  end
end

data = AdventUtils.get_data("6.txt")

lights = Lights.new

data.each_line do |input_string|
  tokens = input_string.split " "
  
  if tokens[0] == "toggle"  
    ul = tokens[1].split ","
    ul[0] = ul[0].to_i
	ul[1] = ul[1].to_i
	lr = tokens[3].split ","
	lr[0] = lr[0].to_i
	lr[1] = lr[1].to_i
	
	#lights.toggle(ul,lr)
	lights.toggle_up(ul,lr)
  elsif tokens[0] == "turn"
    if tokens[1] == "on"
	  new_state = 1
	else
	  #new_state = 0
	  new_state = -1
	end
	
    ul = tokens[2].split ","
	ul[0] = ul[0].to_i
	ul[1] = ul[1].to_i
	lr = tokens[4].split ","	
    lr[0] = lr[0].to_i
	lr[1] = lr[1].to_i
	
	#lights.set_state(ul,lr,new_state)
	lights.set_state_by(ul,lr,new_state)
  end  
end

#puts "Lit lights: #{lights.count_lit_lights}"
puts "Total Brightness: #{lights.count_total_brightness}"