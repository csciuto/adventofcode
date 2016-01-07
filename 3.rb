#!/usr/bin/ruby

require "./advent_utils"

class Deliverer
  attr_accessor :x, :y
  
  def initialize(name)
    @name = name
    @x = 0
	@y = 0
  end
    
  def to_s
    "#{@name} is at #{@x},#{@y}"
  end
end

class House
  attr_accessor :present_count
  
  def initialize
    @present_count = 1
  end
  
end

class HouseMap

  attr_accessor :houses_visited

  # Creates the starting house and visits it
  def initialize
    @x_map = Hash.new
	@houses_visited = 0
	get_house(0,0)
  end
  
  # We have a map of maps here. Look up our coordinates, initializing
  # a new map if the X lookup fails, and a new house if the Y lookup fails
  def get_house(x, y)
    y_map = @x_map[x]
	if y_map.nil?
	  y_map = Hash.new
	  @x_map[x] = y_map
	end
	
	house = y_map[y]
	if house.nil?
	  house = House.new
	  y_map[y] = house
	  @houses_visited += 1
	end
	house.present_count += 1	
	
	house
  end
end

data = AdventUtils.get_data("3.txt")

house_map = HouseMap.new
santa = Deliverer.new("Santa")
robot = Deliverer.new("RoboSanta")

current_deliverer = santa

data.each_char do |char|

  puts current_deliverer

  if char == "<"
    current_deliverer.x -= 1
  elsif char == ">"
    current_deliverer.x += 1
  elsif char == "v"
    current_deliverer.y += 1
  elsif char == "^"
    current_deliverer.y -= 1
  end
  
  house_map.get_house(current_deliverer.x,current_deliverer.y)
  
  puts current_deliverer
  
  if current_deliverer == santa
    current_deliverer = robot
  else
    current_deliverer = santa
  end
  
end

puts "Number of houses visited: #{house_map.houses_visited}"