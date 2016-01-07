#!/usr/bin/ruby

require "./advent_utils"

# From the three linear dimensions, generate the three square dimensions,
# smallest to largest
def self.get_sorted_sides(l,w,h)
  sides = []
  sides << l*w
  sides << w*h
  sides << h*l

  sides.sort!
end

# From the three square dimensions,
# Add the six sides of the box plus one more for the smallest side as slack.
def self.paper_needed(sides)
  dimensions = 2*sides[0] + 2*sides[1] + 2*sides[2]
  dimensions+sides[0]  
end

# Take the two smallest linear dimensions and find the size of the box they make.
# Add the volume of the entire package to that.
def self.ribbon_needed(dimensions)
  ribbon = 2*dimensions[0] + 2*dimensions[1]
  bow = dimensions[0] * dimensions[1] * dimensions[2]
  ribbon+bow
end

data = AdventUtils.get_data("2.txt")
paper_total = 0
ribbon_total = 0

data.each_line do |dimensions|
  d = dimensions.split("x").map(&:to_i)
  
  sides = self.get_sorted_sides(d[0],d[1],d[2])  
  paper_total += self.paper_needed(sides)
  
  sorted_dimensions = d.sort
  ribbon_total += self.ribbon_needed(sorted_dimensions)
end

puts "Paper needed: #{paper_total}"
puts "Ribbon needed: #{ribbon_total}"
