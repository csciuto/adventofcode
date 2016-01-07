#!/usr/bin/ruby

require "./advent_utils"

class City
  attr_accessor :name, :connections, :visited
  
  def initialize(name)
    @connections = []
	@visited = false
	@name = name
  end
  
  def to_s
    output = "City #{name} is #{visited==true ? "visited" : "not visited"}. Connections:\n"		
	connections.each {|connection| output += "\t#{connection.to_s}\n"}
	return output
  end
end

class Connection
  attr_accessor :connect_to, :distance
  
  def to_s   
     "#{connect_to.name} is #{distance} away"
  end
end

cities = {}

data = AdventUtils.get_data("9.txt")

data.each_line do |input_string|
  input_string.chomp!

  tokens = input_string.split(" ")
  city1_name = tokens[0]
  city2_name = tokens[2]
  distance = tokens[4]
  
  if cities[city1_name].nil?
    cities[city1_name] = City.new(city1_name)
  end
  if cities[city2_name].nil?
    cities[city2_name] = City.new(city2_name)
  end
  
  conn1 = Connection.new
  conn1.connect_to = cities[city2_name]
  conn1.distance = distance.to_i
  cities[city1_name].connections << conn1
  
  conn2 = Connection.new
  conn2.connect_to = cities[city1_name]
  conn2.distance = distance.to_i
  cities[city2_name].connections << conn2
  
end

cities.each do |city|
  puts city
end

$shortest_distance = nil
$longest_distance = nil

def visit_city(connection, distance_travelled, left_to_visit)
  distance_travelled += connection.distance
  left_to_visit -= 1
  new_city = connection.connect_to
  
  new_city.visited = true
  if left_to_visit > 0
    new_city.connections.each do |connection|
	  if connection.connect_to.visited == false
	    visit_city(connection, distance_travelled, left_to_visit)		
	  end
	end
  else
    if $shortest_distance.nil? || distance_travelled < $shortest_distance
	  $shortest_distance = distance_travelled
	elsif $longest_distance.nil? || distance_travelled > $longest_distance
	  $longest_distance = distance_travelled
	end
  end
  new_city.visited = false
end

cities.each do |city|
  city[1].connections.each do |connection|
     city[1].visited = true
     visit_city(connection, 0, cities.count-1)
	 city[1].visited = false
  end
end

puts "Shortest distance: #{$shortest_distance}"
puts "Longest distance: #{$longest_distance}"
